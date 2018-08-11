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
    
    var planCost: Int
    
    var photoRate: Float
    var emailRate: Float
    
    var schedule: Schedule
    
    var alive: Bool
    var wasAsleep: Bool
    
    weak var delegate: GameMasterDelegate?
    
    init(rate: Int) {
        self.id = UUID().uuidString
        
        self.planCost = rate
        
        self.memory = 0
        self.alive = true
        self.photoRate = Float(arc4random_uniform(100)) / 100
        self.emailRate = Float(arc4random_uniform(100)) / 100
        self.schedule = Schedule(at: .morning)
        self.wasAsleep = false
    }
    
    func gameStep() {
        guard alive else { return }
        
        self.schedule.incrementTime()
        guard self.schedule.awake else {
            self.wasAsleep = true
            self.delegate?.updateView(for: self)
            return
        }
        
        if self.wasAsleep {
            self.delegate?.bill(self)
            self.wasAsleep = false
        }
        
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
        
        self.delegate?.updateView(for: self)
    }
    
    func backupData(_ amount: Int) {
        guard alive else { return }
        
        memory -= amount
        memory = max(memory, 0)
    }
}
