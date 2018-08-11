//
//  Schedule.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

enum DayPhase: Int {
    case sunrise = 6
    case morning = 8
    case afternoon = 12
    case sunset = 20
    case night = 22
    
    static func from(hour: Int) -> DayPhase{
        if (hour < DayPhase.sunrise.rawValue) {
            return .night
        } else if (hour < DayPhase.morning.rawValue) {
            return .sunrise
        } else if (hour < DayPhase.afternoon.rawValue) {
            return .morning
        } else if (hour < DayPhase.sunset.rawValue) {
            return .afternoon
        } else if (hour < DayPhase.night.rawValue) {
            return .sunset
        } else {
            return .night
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .sunrise:
            return UIColor(red:0.15, green:0.67, blue:0.89, alpha:1.0)
        case .morning:
            return UIColor(red:0.99, green:0.82, blue:0.07, alpha:1.0)
        case .afternoon:
            return UIColor(red:0.97, green:0.58, blue:0.11, alpha:1.0)
        case .sunset:
            return UIColor(red:0.29, green:0.16, blue:0.35, alpha:1.0)
        case .night:
            return UIColor(red:0.20, green:0.09, blue:0.33, alpha:1.0)
        }
    }
}

struct Schedule {
    var currentTime: Int
    
    init(at phase: DayPhase) {
        self.currentTime = phase.rawValue
    }
    
    mutating func incrementTime() {
        self.currentTime = (currentTime + 1) % 24
    }
    
    var phase: DayPhase {
        return DayPhase.from(hour: self.currentTime)
    }
    
    var awake: Bool {
        return self.phase != .night
    }
}
