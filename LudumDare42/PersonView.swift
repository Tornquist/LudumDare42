//
//  PersonView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

protocol PersonViewEventsDelegate: class {
    func deathAnimationComplete(forID personID: String)
    func personSelected(withID personID: String)
}

class PersonView: UIView {
    static let minWidth: CGFloat = 82
    
    var personID: String!
    var startedDeath: Bool = false
    
    weak var delegate: PersonViewEventsDelegate?
    
    var view: UIView!
    @IBOutlet weak var phoneView: PhoneView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadViewFromNib()
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadViewFromNib()
        self.configureView()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "PersonView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let minWidthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: PersonView.minWidth)
        self.addConstraint(minWidthConstraint)
        
        self.addSubview(self.view)
    }
    
    func configureView() {
        self.backgroundColor = .clear
        self.view.backgroundColor = .clear
        self.phoneView?.backgroundColor = .clear
    }
    
    func updateFor(person: Person) {
        guard person.alive else {
            self.showDeath(for: person)
            return
        }
        
        let memoryPercent = CGFloat(person.memory) / 100
        if (phoneView.memoryPercent != memoryPercent) {
            phoneView.memoryPercent = memoryPercent
            phoneView.setNeedsDisplay()
        }
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.personSelected(withID: self.personID)
    }
    
    func showDeath(for person: Person) {
        guard !self.startedDeath else { return }
        self.startedDeath = true
        
        UIView.animate(withDuration: 1, animations: {
            self.phoneView.alpha = 0
            self.backgroundColor = .red
        }) { (done) in
            self.delegate?.deathAnimationComplete(forID: self.personID)
        }
    }
}
