//
//  MenuViewController.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameSubtitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    func configureView() {
        self.gameTitle.text = NSLocalizedString("SpaceIO", comment: "")
        self.gameSubtitle.text = NSLocalizedString("Cloud Storage of the Future", comment: "")
        
        self.playButton.setTitle(NSLocalizedString("Play", comment: ""), for: .normal)
        self.aboutButton.setTitle(NSLocalizedString("About", comment: ""), for: .normal)
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        let gameView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameView")
        self.present(gameView, animated: true, completion: nil)
    }
    
    @IBAction func aboutPressed(_ sender: UIButton) {
        let instructionsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "instructionsView")
        self.present(instructionsView, animated: true, completion: nil)
    }
}
