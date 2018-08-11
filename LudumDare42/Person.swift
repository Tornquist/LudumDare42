//
//  Person.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import Foundation

class Person {
    var id: String
    
    // Ranges from 0 -> 100
    var memory: Int
    
    var photoRate: Float
    var emailRate: Float
    
    var alive: Bool
    
    weak var delegate: GameMasterDelegate?
    
    init() {
        self.id = UUID().uuidString
        self.memory = 0
        self.alive = true
        self.photoRate = Float(arc4random_uniform(100)) / 100
        self.emailRate = Float(arc4random_uniform(100)) / 100
    }
    
    func gameStep() {
        guard alive else { return }
        
        let random = Float(arc4random_uniform(100)) / 100
        let takePhoto = random < photoRate
        let sendEmail = random < emailRate
        
        if (takePhoto) { memory += Costs.photo.rawValue }
        if (sendEmail) { memory += Costs.email.rawValue }
        
        if memory > 100 {
            self.memory = 100
            self.alive = false
            self.delegate?.personDied(self)
        }
        
        if (takePhoto) { self.delegate?.photoTaken(by: self) }
        if (sendEmail) { self.delegate?.emailSent(by: self) }
    }
    
    func backupData() {
        guard alive else { return }
        
        memory += Costs.backingUp.rawValue
        memory = max(memory, 0)
    }
}
