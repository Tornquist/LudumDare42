//
//  ViewController.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/10/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }

    func configureView() {
        for _ in 0..<15 {
            let personView = PersonView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            let minWidthConstraint = NSLayoutConstraint(item: personView, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: PersonView.minWidth)
            personView.addConstraint(minWidthConstraint)
            self.stackView.addArrangedSubview(personView)
        }
    }
}

