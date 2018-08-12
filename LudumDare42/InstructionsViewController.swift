//
//  InstructionsViewController.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    func configureView() {
        self.backButton.setTitle(NSLocalizedString("Back", comment: ""), for: .normal)
        self.titleLabel.text = NSLocalizedString("About", comment: "")
        
        let instructions = InstructionsView(frame: .zero)
        instructions.translatesAutoresizingMaskIntoConstraints = false
        self.scrollViewContentView.addSubview(instructions)
        
        let top = NSLayoutConstraint(item: instructions, attribute: .top, relatedBy: .equal, toItem: self.scrollViewContentView, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: instructions, attribute: .bottom, relatedBy: .equal, toItem: self.scrollViewContentView, attribute: .bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: instructions, attribute: .left, relatedBy: .equal, toItem: self.scrollViewContentView, attribute: .left, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: instructions, attribute: .right, relatedBy: .equal, toItem: self.scrollViewContentView, attribute: .right, multiplier: 1, constant: 0)
        self.scrollViewContentView.addConstraints([top, bottom, left, right])
        self.scrollView.setNeedsLayout()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
