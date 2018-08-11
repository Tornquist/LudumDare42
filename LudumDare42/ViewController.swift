//
//  ViewController.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/10/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameMasterViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    var peopleViews: [String: PersonView] = [:]
    
    let gameMaster = GameMaster()
    
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
    }
    
    // MARK: - Game Master View Delegate
    
    func resetGameBoard() {
        self.stackView.arrangedSubviews.forEach { (view) in
            self.stackView.removeArrangedSubview(view)
        }
        self.peopleViews.removeAll()
    }
    
    func add(person: Person) {
        let existingView = peopleViews[person.id]
        guard existingView == nil else { return }
        
        let personView = PersonView(frame: .zero)
        personView.personID = person.id
        personView.delegate = self.gameMaster
        
        self.peopleViews[person.id] = personView
        self.stackView.addArrangedSubview(personView)
    }
    
    func showEmailFor(person: Person) {
        if let view = peopleViews[person.id] {
            view.showEmail()
            view.updateFor(person: person)
        }
    }
    
    func showPhotoFor(person: Person) {
        if let view = peopleViews[person.id] {
            view.showPhoto()
            view.updateFor(person: person)
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
        }
    }
}
