//
//  EmailView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/10/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

@IBDesignable
class EmailView: UIView {
    static let aspectRatio: CGFloat = 1.42
    
    // Color Declarations
    @IBInspectable var letterBorderColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var letterFillColor = UIColor(red: 0.116, green: 0.370, blue: 0.892, alpha: 0.523)
    
    // Context
    let paintCodeWidth: CGFloat = 100
    let paintCodeHeight: CGFloat = 70
    
    let paintCodeFlapX: CGFloat = 50
    let paintCodeFlapY: CGFloat = 50
    
    let paintCodeRightLineX: CGFloat = 66
    let paintCodeRightLineY: CGFloat = 35
    
    let paintCodeLeftLineX: CGFloat = 33
    let paintCodeLeftLineY: CGFloat = 35
    
    let paintCodeLineWidth: CGFloat = 2.5

    override func draw(_ rect: CGRect) {
        // Values for Rect Context
        let flapX = paintCodeFlapX / paintCodeWidth * rect.width
        let flapY = paintCodeFlapY / paintCodeHeight * rect.height
        
        let leftX = paintCodeLeftLineX / paintCodeWidth * rect.width
        let leftY = paintCodeLeftLineY / paintCodeHeight * rect.height
        
        let rightX = paintCodeRightLineX / paintCodeWidth * rect.width
        let rightY = paintCodeRightLineY / paintCodeHeight * rect.height
        
        let lineWidth = paintCodeLineWidth / paintCodeWidth * rect.width
        
        // Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRect(x: lineWidth/2, y: lineWidth/2, width: rect.width - lineWidth, height: rect.height - lineWidth))
        letterFillColor.setFill()
        backgroundPath.fill()
        letterBorderColor.setStroke()
        backgroundPath.lineWidth = lineWidth
        backgroundPath.stroke()
        
        // Flap Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: flapX, y: flapY))
        bezierPath.addLine(to: CGPoint(x: rect.width, y: 0))
        letterFillColor.setFill()
        bezierPath.fill()
        letterBorderColor.setStroke()
        bezierPath.lineWidth = lineWidth
        bezierPath.stroke()
        
        // Right Line
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: rect.width, y: rect.height))
        bezier2Path.addLine(to: CGPoint(x: rightX, y: rightY))
        letterFillColor.setFill()
        bezier2Path.fill()
        letterBorderColor.setStroke()
        bezier2Path.lineWidth = lineWidth
        bezier2Path.stroke()
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 0, y: rect.height))
        bezier3Path.addLine(to: CGPoint(x: leftX, y: leftY))
        letterFillColor.setFill()
        bezier3Path.fill()
        letterBorderColor.setStroke()
        bezier3Path.lineWidth = lineWidth
        bezier3Path.stroke()
    }
}
