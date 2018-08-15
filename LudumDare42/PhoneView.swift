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
    @IBInspectable var screenColor: UIColor = .white
    @IBInspectable var phoneColor: UIColor = .black
    @IBInspectable var memoryGood: UIColor = .green
    @IBInspectable var memoryMedium: UIColor = .yellow
    @IBInspectable var memoryBad: UIColor = .red
    var memoryClear: UIColor = .clear
    
    // Context
    let paintCodeWidth: CGFloat = 80
    let paintCodeHeight: CGFloat = 140
    let paintCodeScreenOffsetX: CGFloat = 3
    let paintCodeScreenOffsetY: CGFloat = 12
    let paintCodeScreenWidth: CGFloat = 74
    let paintCodeScreenHeight: CGFloat = 116
    let paintCodePhoneCorner: CGFloat = 10
    let paintCodeScreenCorner: CGFloat = 2
    
    let paintCodeButtonX: CGFloat = 26
    let paintCodeButtonY: CGFloat = 131
    let paintCodeButtonWidth: CGFloat = 28
    let paintCodeButtonHeight: CGFloat = 6
    let paintCodeButtonCornerRadius: CGFloat = 3
    
    let paintCodeAccentCorner: CGFloat = 2.5
    let paintCodeTopSmallAccentX: CGFloat = 23
    let paintCodeTopSmallAccentY: CGFloat = 4
    let paintCodeTopSmallAccentSize: CGFloat = 5
    let paintCodeTopLargeAccentX: CGFloat = 31
    let paintCodeTopLargeAccentY: CGFloat = 4
    let paintCodeTopLargeAccentWidth: CGFloat = 26
    let paintCodeTopLargeAccentHeight: CGFloat = 5
    
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
        let buttonWidth = paintCodeButtonWidth / paintCodeWidth * rect.width
        let buttonHeight = paintCodeButtonHeight / paintCodeHeight * rect.height
        let buttonCornerRadius = paintCodeButtonCornerRadius / paintCodeWidth * rect.width
        
        let accentCorner = paintCodeAccentCorner / paintCodeWidth * rect.width
        let topSmallAccentX = paintCodeTopSmallAccentX / paintCodeWidth * rect.width
        let topSmallAccentY = paintCodeTopSmallAccentY / paintCodeHeight * rect.height
        let topSmallAccentSize = paintCodeTopSmallAccentSize / paintCodeWidth * rect.width
        let topLargeAccentX = paintCodeTopLargeAccentX / paintCodeWidth * rect.width
        let topLargeAccentY = paintCodeTopLargeAccentY / paintCodeHeight * rect.height
        let topLargeAccentWidth = paintCodeTopLargeAccentWidth / paintCodeWidth * rect.width
        let topLargeAccentHeight = paintCodeTopLargeAccentHeight / paintCodeHeight * rect.height
        
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
        let buttonPath = UIBezierPath(roundedRect: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight), cornerRadius: buttonCornerRadius)
        screenColor.setFill()
        buttonPath.fill()
        
        // Accent Drawing
        let topLargeAccentPath = UIBezierPath(roundedRect: CGRect(x: topLargeAccentX, y: topLargeAccentY, width: topLargeAccentWidth, height: topLargeAccentHeight), cornerRadius: accentCorner)
        screenColor.setFill()
        topLargeAccentPath.fill()
        
        let topSmallAccentPath = UIBezierPath(roundedRect: CGRect(x: topSmallAccentX, y: topSmallAccentY, width: topSmallAccentSize, height: topSmallAccentSize), cornerRadius: accentCorner)
        screenColor.setFill()
        topSmallAccentPath.fill()
        
        // MemoryIndicator Drawing
        let memoryIndicatorPath = UIBezierPath(roundedRect: CGRect(x: screenXStart, y: memoryY, width: screenWidth, height: memoryHeight), cornerRadius: screenCorner)
        memoryColor.setFill()
        memoryIndicatorPath.fill()
    }
}
