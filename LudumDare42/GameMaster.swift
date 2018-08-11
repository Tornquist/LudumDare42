//
//  GameMaster.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import Foundation

protocol GameMasterDelegate: class {
    func photoTaken(by person: Person)
    func emailSent(by person: Person)
    func personDied(_ person: Person)
    func updateView(for person: Person)
}

protocol GameMasterViewDelegate: class {
    func resetGameBoard()
    func add(person: Person)
    func update(person: Person)
    func showEmailFor(person: Person)
    func showPhotoFor(person: Person)
    func remove(person: Person)
    func refreshNav(reputation: Int, money: Int, price: Int, upgradeEnabled: Bool)
}

class GameMaster: GameMasterDelegate, PersonViewEventsDelegate {
    var gameTimer: Timer?
    
    var people: [Person] = []
    var birthRate: Float = 0.2
    
    var reputation: Int = 50 { didSet { self.updateBirthRate() }}
    var money: Int = 0
    var price: Int = 20 { didSet { self.updateBirthRate() }}
    var upgradePrice: Int = 80
    var backupRate: Int = 3
    
    let maxPrice: Int = 150
    let minPrice: Int = 5
    let reputationCost: Int = 5
    
    weak var viewDelegate: GameMasterViewDelegate!
    
    func newGame() {
        self.viewDelegate?.resetGameBoard()
        self.people.removeAll()
        self.newPerson()
        
        self.birthRate = 0.2
        self.reputation = 50
        self.money = 0
        self.price = 20
        self.upgradePrice = 80
        self.backupRate = 3
        
        self.sendNavUpdate()
    }
    
    func startGame() {
        gameTimer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        
        gameTimer = Timer(timeInterval: 0.5, target: self, selector: #selector(gameStep), userInfo: nil, repeats: true)
        RunLoop.main.add(gameTimer!, forMode: RunLoopMode.commonModes)
    }
    
    func stopGame() {
        gameTimer?.invalidate()
    }
    
    @objc
    func gameStep() {
        self.generatePeopleAsNeeded()
        self.people.forEach { $0.gameStep() }
        print(Date())
    }
    
    func generatePeopleAsNeeded() {
        let random = Float(arc4random_uniform(100)) / 100
        if (random <= birthRate) {
            self.newPerson()
        }
    }
    
    func newPerson() {
        let newPerson = Person()
        newPerson.delegate = self
        people.append(newPerson)
        self.viewDelegate?.add(person: newPerson)
    }
    
    // MARK: - Game Master
    
    func emailSent(by person: Person) {
        self.viewDelegate?.showEmailFor(person: person)
    }
    
    func photoTaken(by person: Person) {
        self.viewDelegate?.showPhotoFor(person: person)
    }
    
    func updateView(for person: Person) {
        self.viewDelegate?.update(person: person)
    }
    
    func personDied(_ person: Person) {
        self.viewDelegate?.update(person: person)
        self.reputation -= self.reputationCost
        self.sendNavUpdate()
    }
    
    // MARK: - Person View Events Delegate
    
    func personSelected(withID personID: String) {
        if let person = self.lookupPerson(withID: personID) {
            person.backupData(self.backupRate)
            self.viewDelegate?.update(person: person)
        }
    }
    
    func deathAnimationComplete(forID personID: String) {
        if let person = self.lookupPerson(withID: personID) {
            self.viewDelegate?.remove(person: person)
            if let personIndex = people.index(where: { (testPerson) -> Bool in
                return person.id == testPerson.id
            }) {
                self.people.remove(at: personIndex)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func lookupPerson(withID id: String) -> Person? {
        return self.people.first { $0.id == id }
    }
    
    func canUpgrade() -> Bool {
        return self.money >= self.upgradePrice
    }
    
    func sendNavUpdate() {
        self.viewDelegate?.refreshNav(reputation: self.reputation, money: self.money, price: self.price, upgradeEnabled: self.canUpgrade())
    }
    
    func updateBirthRate() {
        // Starting BirthRate = 0.2
        
        let baseBirthRate: Float = 0.2
        
        // 0.04 per reputation tier of 20 (ranges from 0 to 100)
        let reputationBonus: Float = Float(Int(self.reputation / 20)) * 0.04
        
        // Below median gives a max of 0.2 above takes up to 0.1 away
        let pricePercent = Float(self.price - self.minPrice) / Float(self.maxPrice - self.minPrice)
        let inversePricePercent = 1 - pricePercent
        
        let belowMedian = Float(self.price) < Float(self.maxPrice) / 2.0
        let multiplier: Float = belowMedian ? 0.2 : 0.1
        
        let priceBonus = (inversePricePercent - 0.5) / 0.5 * multiplier
        
        self.birthRate = baseBirthRate + reputationBonus + priceBonus
    }
    
    // MARK: - Pricing
    
    func increasePrice() {
        self.price += 5
        self.price = min(self.price, self.maxPrice)
        self.sendNavUpdate()
    }
    
    func decreasePrice() {
        self.price -= 5
        self.price = max(self.price, self.minPrice)
        self.sendNavUpdate()
    }
    
    func upgradeSpeed() {
        if self.canUpgrade() {
            self.money = self.money - self.upgradePrice
            self.upgradePrice = Int(Double(self.upgradePrice) * 1.5)
            self.backupRate = Int(Double(self.backupRate) * 1.5)
        }
        self.sendNavUpdate()
    }
}
