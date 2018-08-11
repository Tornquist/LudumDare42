//
//  PhoneView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/10/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

@IBDesignable
class PhoneView: UIView {
    static let aspectRatio: CGFloat = 0.5714
    
    // Color Declarations
    @IBInspectable var screenColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable var phoneColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var memoryGood = UIColor(red: 0.000, green: 1.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var memoryMedium = UIColor(red: 1.000, green: 0.998, blue: 0.000, alpha: 1.000)
    @IBInspectable var memoryBad = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
    var memoryClear = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.000)
    
    // Context
    let paintCodeWidth: CGFloat = 80
    let paintCodeHeight: CGFloat = 140
    let paintCodeScreenOffsetX: CGFloat = 10
    let paintCodeScreenOffsetY: CGFloat = 10
    let paintCodeScreenWidth: CGFloat = 60
    let paintCodeScreenHeight: CGFloat = 110
    let paintCodePhoneCorner: CGFloat = 10
    let paintCodeScreenCorner: CGFloat = 2
    
    let paintCodeButtonX: CGFloat = 33
    let paintCodeButtonY: CGFloat = 123
    let paintCodeButtonSize: CGFloat = 14
    
    // 0 -> 1: 0 = no memory used
    @IBInspectable var memoryPercent: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        // Values for Rect Context
        let screenXStart = paintCodeScreenOffsetX / paintCodeWidth * rect.width
        let screenYStart = paintCodeScreenOffsetY / paintCodeHeight * rect.height
        let screenYEnd = paintCodeScreenHeight / paintCodeHeight * rect.height
        
        let screenWidth = paintCodeScreenWidth / paintCodeWidth * rect.width
        let screenHeight = paintCodeScreenHeight / paintCodeHeight * rect.height
        
        let phoneCorner = paintCodePhoneCorner / paintCodeWidth * rect.width
        let screenCorner = paintCodeScreenCorner / paintCodeWidth * rect.width
        
        let buttonX = paintCodeButtonX / paintCodeWidth * rect.width
        let buttonY = paintCodeButtonY / paintCodeHeight * rect.height
        let buttonSize = paintCodeButtonSize / paintCodeWidth * rect.width
        
        // Variable Declarations
        let memoryInverse: CGFloat = 1 - memoryPercent
        let memoryY: CGFloat = screenYStart + screenYEnd * memoryInverse
        let memoryHeight: CGFloat = screenYEnd * memoryPercent
        let memoryColor = memoryPercent == 0 ? memoryClear : (memoryPercent < 0.33 ? memoryGood : (memoryPercent < 0.66 ? memoryMedium : memoryBad))
        
        // Phone Case Drawing
        let phoneCasePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: rect.width, height: rect.height), cornerRadius: phoneCorner)
        phoneColor.setFill()
        phoneCasePath.fill()
        
        // Screen Drawing
        let screenPath = UIBezierPath(roundedRect: CGRect(x: screenXStart, y: screenYStart, width: screenWidth, height: screenHeight), cornerRadius: screenCorner)
        screenColor.setFill()
        screenPath.fill()
        
        // Button Drawing
        let buttonPath = UIBezierPath(ovalIn: CGRect(x: buttonX, y: buttonY, width: buttonSize, height: buttonSize))
        screenColor.setFill()
        buttonPath.fill()
        
        // MemoryIndicator Drawing
        let memoryIndicatorPath = UIBezierPath(roundedRect: CGRect(x: screenXStart, y: memoryY, width: screenWidth, height: memoryHeight), cornerRadius: screenCorner)
        memoryColor.setFill()
        memoryIndicatorPath.fill()
    }

}
