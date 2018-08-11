//
//  PersonView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class PersonView: UIView {
    static let minWidth: CGFloat = 82
    
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
        self.addSubview(self.view)
    }
    
    func configureView() {
        self.backgroundColor = .clear
        self.view.backgroundColor = .clear
        self.phoneView?.backgroundColor = .clear
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        
    }
}
