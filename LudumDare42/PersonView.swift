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
    
    func showEmail() {
        self.showParticle(for: .email)
    }
    
    func showPhoto() {
        self.showParticle(for: .photo)
    }
    
    func showParticle(for type: ParticleType) {
        let centerX = (self.phoneView.frame.minX + self.phoneView.frame.maxX) / 2
        let topY = self.phoneView.frame.minY
        
        var minFinish: CGFloat = 0
        var maxFinish: CGFloat = self.frame.maxX
        
        let minSpread = PersonView.minWidth * 3
        if self.frame.width < minSpread {
            let extra = minSpread - self.frame.width
            minFinish = minFinish - extra / 2
            maxFinish = maxFinish + extra / 2
        }
        
        // 0.9 -> 1.1
        let frameAdjustment = 1 + CGFloat(Int(arc4random_uniform(10)) - 5) / 50
        let emailWidth = self.phoneView.frame.width * frameAdjustment
        let aspectRatio = type == .email ? EmailView.aspectRatio : PhotoView.aspectRatio
        let emailHeight = emailWidth / aspectRatio
        
        let exitPercent = CGFloat(arc4random_uniform(10)) / 10
        let exitPosition = minFinish + (maxFinish - minFinish) * exitPercent
        
        let startFrame = CGRect(x: centerX - emailWidth/2, y: topY - emailHeight/2, width: emailWidth, height: emailHeight)
        let endFrame = CGRect(x: exitPosition - emailWidth/2, y: -emailHeight*2, width: emailWidth*0.8, height: emailHeight*0.8)
        
        let particleView: UIView = type == .email ? EmailView(frame: startFrame) : PhotoView(frame: startFrame)
        
        self.addSubview(particleView)
        
        UIView.animate(withDuration: 2, animations: {
            particleView.frame = endFrame
        }) { (done) in
            particleView.removeFromSuperview()
        }
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
