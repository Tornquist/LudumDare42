//
//  GameViewController.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/10/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameMasterViewDelegate {
    // Views
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var reputationView: UIProgressView!
    
    @IBOutlet weak var moneyTitle: UILabel!
    @IBOutlet weak var moneyValue: UILabel!
    @IBOutlet weak var upgradeSpeedButton: UIButton!
    @IBOutlet weak var increasePriceButton: UIButton!
    @IBOutlet weak var decreasePriceButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketShareLabel: UILabel!
    @IBOutlet weak var maxMarketShare: UIProgressView!
    @IBOutlet weak var currentMarketShare: UIProgressView!
    
    @IBOutlet weak var gameOverEffectView: UIVisualEffectView!
    @IBOutlet weak var gameOverContentView: UIView!
    @IBOutlet weak var gameOverTitle: UILabel!
    @IBOutlet weak var gameOverMessage: UILabel!
    @IBOutlet weak var gameOverButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    // Other
    
    let gameMaster = GameMaster()
    var peopleViews: [String: PersonView] = [:]
    var backgroundViews: [String: UIView] = [:]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.gameMaster.viewDelegate = self
        self.gameMaster.newGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.gameMaster.startGame()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.gameMaster.stopGame()
    }
    
    // MARK: - View Configuration

    func configureView() {
        self.view.backgroundColor = .black
        
        self.reputationLabel.text = NSLocalizedString("Reputation", comment: "")
        self.reputationLabel.textColor = .white
        self.reputationView.trackTintColor = .clear
        
        self.moneyTitle.text = NSLocalizedString("Money", comment: "")
        self.moneyTitle.textColor = .white
        self.moneyValue.text = "$0"
        self.moneyValue.textColor = .white
        
        self.priceLabel.textColor = .white
        self.priceLabel.text = "$20"
        
        self.upgradeSpeedButton.setTitleColor(.green, for: .normal)
        self.upgradeSpeedButton.setTitleColor(.gray, for: .disabled)
        self.upgradeSpeedButton.setTitle(NSLocalizedString("Upgrade Speed", comment: ""), for: .normal)
        self.upgradeSpeedButton.isEnabled = false
        
        self.marketShareLabel.text = NSLocalizedString("Market", comment: "")
        self.marketShareLabel.textColor = .white
        // maxMarketShare uses default progressView colors
        self.maxMarketShare.setProgress(0, animated: false)
        self.currentMarketShare.trackTintColor = .clear
        self.currentMarketShare.progressTintColor = .green
        self.currentMarketShare.setProgress(0, animated: false)
        
        self.gameOverTitle.text = NSLocalizedString("Game Over", comment: "")
        self.gameOverMessage.text = "You lost."
        self.menuButton.setTitle(NSLocalizedString("Quit", comment: ""), for: .normal)
        self.menuButton.setTitleColor(.red, for: .normal)
        
        self.gameOverEffectView.isHidden = true
        self.gameOverContentView.isHidden = true
    }
    
    // MARK: - Game Master View Delegate
    
    func resetGameBoard() {
        self.stackView.arrangedSubviews.forEach { (view) in
            self.stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        self.backgroundViews.forEach { (key, value) in
            value.removeFromSuperview()
        }
        self.peopleViews.removeAll()
        self.backgroundViews.removeAll()
        
        self.gameOverEffectView.isHidden = true
        self.gameOverContentView.isHidden = true
    }
    
    func add(person: Person) {
        let existingView = peopleViews[person.id]
        guard existingView == nil else { return }
        
        let personView = PersonView(frame: .zero)
        personView.personID = person.id
        personView.delegate = self.gameMaster
        
        let personViewBackground = UIView(frame: .zero)
        personViewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: personView, attribute: .top, relatedBy: .equal, toItem: personViewBackground, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: personView, attribute: .bottom, relatedBy: .equal, toItem: personViewBackground, attribute: .bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: personView, attribute: .left, relatedBy: .equal, toItem: personViewBackground, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: personView, attribute: .right, relatedBy: .equal, toItem: personViewBackground, attribute: .right, multiplier: 1, constant: 0)
        
        personView.backgroundColorView = personViewBackground
        
        self.peopleViews[person.id] = personView
        self.backgroundViews[person.id] = personViewBackground
        self.stackView.addArrangedSubview(personView)
        self.view.insertSubview(personViewBackground, belowSubview: self.scrollView)
        self.view.addConstraints([top, bottom, left, right])
    }
    
    func showEmailFor(person: Person) {
        if let view = peopleViews[person.id] {
            view.showEmail()
        }
    }
    
    func showPhotoFor(person: Person) {
        if let view = peopleViews[person.id] {
            view.showPhoto()
        }
    }
    
    func update(person: Person) {
        if let view = peopleViews[person.id] {
            view.updateFor(person: person)
        }
    }
    
    func remove(person: Person) {
        if let personView = peopleViews[person.id] {
            self.stackView.removeArrangedSubview(personView)
            self.peopleViews.removeValue(forKey: person.id)
            
            self.backgroundViews[person.id]?.removeFromSuperview()
            self.backgroundViews.removeValue(forKey: person.id)
        }
    }
    
    func refreshNav(reputation: Int, money: Int, price: Int, upgradeEnabled: Bool, currentShare: Float, maxShare: Float) {
        let reputationPercent = Float(reputation) / 100.0
        self.reputationView.setProgress(reputationPercent, animated: true)
        let reputationColor: UIColor = reputationPercent > 0.66 ? .green : (reputationPercent > 0.33 ? .yellow : .red)
        self.reputationView.progressTintColor = reputationColor
        
        self.moneyValue.text = "$\(money)"
        self.priceLabel.text = "$\(price)"
        
        self.upgradeSpeedButton.isEnabled = upgradeEnabled
        
        self.currentMarketShare.setProgress(currentShare, animated: true)
        self.maxMarketShare.setProgress(maxShare, animated: true)
    }
    
    func showVictory() {
        self.gameOverEffectView.isHidden = false
        self.gameOverContentView.isHidden = false
        
        self.gameOverTitle.text = NSLocalizedString("You Win!", comment: "")
        self.gameOverMessage.text = NSLocalizedString("You earned enough market share to get acquired. Enjoy your long vacation!", comment: "")
        self.gameOverButton.setTitle(NSLocalizedString("Replay", comment: ""), for: .normal)
    }
    
    func showGameOver(maxShare: Float) {
        self.gameOverEffectView.isHidden = false
        self.gameOverContentView.isHidden = false
        
        let marketShareString = String(format: "%.3f", maxShare)
        
        self.gameOverTitle.text = NSLocalizedString("Game Over", comment: "")
        self.gameOverMessage.text = NSLocalizedString("Your reputation went too low. There's no recovering from that.\n\nMax Market Share: \(marketShareString)%", comment: "")
        self.gameOverButton.setTitle(NSLocalizedString("Retry", comment: ""), for: .normal)
    }
    
    // MARK: - Events
    
    @IBAction func priceIncreasePressed(_ sender: UIButton) {
        self.gameMaster.increasePrice()
    }
    
    @IBAction func priceDecresePressed(_ sender: UIButton) {
        self.gameMaster.decreasePrice()
    }
    
    @IBAction func upgradeSpeedPressed(_ sender: UIButton) {
        self.gameMaster.upgradeSpeed()
    }
    
    @IBAction func retryPressed(_ sender: UIButton) {
        self.gameMaster.newGame()
        self.gameMaster.startGame()
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
