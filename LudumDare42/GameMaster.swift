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
}

protocol GameMasterViewDelegate: class {
    func resetGameBoard()
    func add(person: Person)
    func update(person: Person)
    func showEmailFor(person: Person)
    func showPhotoFor(person: Person)
    func remove(person: Person)
}

class GameMaster: GameMasterDelegate, PersonViewEventsDelegate {
    var gameTimer: Timer?
    
    var people: [Person] = []
    var birthRate: Float = 0.02
    
    weak var viewDelegate: GameMasterViewDelegate!
    
    func newGame() {
        self.viewDelegate?.resetGameBoard()
        self.people.removeAll()
        self.newPerson()
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
    
    func personDied(_ person: Person) {
        self.viewDelegate?.update(person: person)
    }
    
    // MARK: - Person View Events Delegate
    
    func personSelected(withID personID: String) {
        if let person = self.lookupPerson(withID: personID) {
            person.backupData()
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
}
