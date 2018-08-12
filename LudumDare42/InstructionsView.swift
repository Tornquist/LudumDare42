//
//  InstructionsView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

class InstructionsView: UIView {

    var view: UIView!
    
    @IBOutlet weak var aboutSpaceIOTitle: UILabel!
    @IBOutlet weak var aboutSpaceIOContent: UILabel!
    
    @IBOutlet weak var premiseTitle: UILabel!
    @IBOutlet weak var premiseContent: UILabel!
    
    @IBOutlet weak var tipsTitle: UILabel!
    @IBOutlet weak var tip1: UILabel!
    @IBOutlet weak var tip1Red: UILabel!
    @IBOutlet weak var tip1Yellow: UILabel!
    @IBOutlet weak var tip1Green: UILabel!
    @IBOutlet weak var tip2: UILabel!
    @IBOutlet weak var tip3: UILabel!
    @IBOutlet weak var tip4: UILabel!
    @IBOutlet weak var tip5: UILabel!
    @IBOutlet weak var tip6: UILabel!
    @IBOutlet weak var tip7: UILabel!
    
    @IBOutlet weak var sunriseView: UIView!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var morningView: UIView!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var afternoonView: UIView!
    @IBOutlet weak var afternoonLabel: UILabel!
    @IBOutlet weak var sunsetView: UIView!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var nightView: UIView!
    @IBOutlet weak var nightLabel: UILabel!
    
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsContent: UILabel!
    
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
        let nib = UINib(nibName: "InstructionsView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(self.view)
    }
    
    func configureView() {
        self.aboutSpaceIOTitle.text = "About SpaceIO"
        self.aboutSpaceIOContent.text = """
        SpaceIO is a new kind of cell phone company. Instead of having to take the time to manage your own phone, back up data, etc. (All the things that make cell phones hard), we do it for you! Just sign up for a SpaceIO plan, and your data will be automatically backed up. You won't have to worry about a thing, not even about running out of space!
        """
        
        self.premiseTitle.text = "Premise"
        self.premiseContent.text = """
        As a SpaceIO operator, it is your responsibility to back up data on customer's phones. From the SpaceIO interface just click on a user to back up some of their data.
        
        Each customer will pay their SpaceIO fee every morning (in their respective time zone). A customer's fee is set when they sign up.
        
        Lower prices will attract more customers, but pricing the product too low will make it hard to keep a good reputation.
        """
        
        self.tipsTitle.text = "Tips"
        self.tip1.text = "1. When SpaceIO fails to keep customers from running out of space, they take their business elsewhere."
        self.tip1Red.text = "Available memory is low."
        self.tip1Yellow.text = "Available memory is okay."
        self.tip1Green.text = "Available memory is great! There is plenty."
        self.tip2.text = "2. SpaceIO earns more reputation from customers with a low plan price than customers with a high price."
        self.tip3.text = "3. SpaceIO loses reputation whenever a customer cancels their contract."
        self.tip4.text = "4. If SpaceIO's reputation goes to zero, the company will close"
        self.tip5.text = "5. Use the 🔽 and 🔼 buttons to adjust the introductory plan price."
        self.tip6.text = "6. When an infrastructure upgrade is available, the 'Upgrade Speed' button will light up. This upgrade allows more customer data to be backed up with every click."
        self.tip7.text = "7. Customers don't user their phones when they are asleep. A customer's timezone will be shown with background color."
        
        self.sunriseView.backgroundColor = DayPhase.sunrise.getColor()
        self.sunriseLabel.text = "Sunrise"
        self.morningView.backgroundColor = DayPhase.morning.getColor()
        self.morningLabel.text = "Morning"
        self.afternoonView.backgroundColor = DayPhase.afternoon.getColor()
        self.afternoonLabel.text = "Afternoon"
        self.sunsetView.backgroundColor = DayPhase.sunset.getColor()
        self.sunsetLabel.text = "Sunset"
        self.nightView.backgroundColor = DayPhase.night.getColor()
        self.nightLabel.text = "Night (Asleep)"
        
        self.detailsTitle.text = "Details"
        self.detailsContent.text = """
        This game was developed by Nathan Tornquist on August 10th and 11th, 2018 for Ludum Dare 42.
        
        Ludum Dare is a 48 hour game development competition. The theme is announced at the start of the competition, and the participants have 48 hours to design a game from scratch, including assets.
        """
    }
}
