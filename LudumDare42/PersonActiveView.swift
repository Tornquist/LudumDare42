//
//  PersonActiveView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

@IBDesignable
class PersonActiveView: UIView {
    static let aspectRatio: CGFloat = 0.6132
    
    // Variables
    @IBInspectable var personColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var playerAnimation: CGFloat = 1
    @IBInspectable var lineWidth: CGFloat = 3
    
    // Context
    let paintCodeWidth: CGFloat = 65
    let paintCodeHeight: CGFloat = 106
    
    override func draw(_ rect: CGRect) {
        
        //// Variable Declarations
        let playerKeyframe: CGFloat = playerAnimation < 0.5 ? playerAnimation * 2 : (-playerAnimation + 1) * 2
        let armA: CGFloat = -180 * (1 - playerKeyframe)
        let armB: CGFloat = -180 * playerKeyframe
        let legA: CGFloat = 90 * playerKeyframe
        let legB: CGFloat = 20 - 90 * playerKeyframe
        
        let context = UIGraphicsGetCurrentContext()
        
        // Body
        let bezierPath = UIBezierPath()
        bezierPath.move(to: correct(CGPoint(x: 32.5, y: 27.5), in: rect))
        bezierPath.addLine(to: correct(CGPoint(x: 32.5, y: 72.5), in: rect))
        personColor.setStroke()
        bezierPath.lineWidth = lineWidth
        bezierPath.stroke()
        
        // Head
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 19.5 / paintCodeWidth * rect.width, y: 1.5 / paintCodeHeight * rect.height, width: 26 / paintCodeWidth * rect.width, height: 26 / paintCodeHeight * rect.height))
        personColor.setStroke()
        ovalPath.lineWidth = lineWidth
        ovalPath.stroke()
        
        // Leg B
        context!.saveGState()
        context!.translateBy(x: 33.5 / paintCodeWidth * rect.width, y: 71.5 / paintCodeHeight * rect.height)
        context!.rotate(by: -legB * .pi / 180)
        
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: correct(CGPoint(x: 0, y: 0), in: rect))
        bezier2Path.addLine(to: correct(CGPoint(x: 16, y: 16), in: rect))
        bezier2Path.addLine(to: correct(CGPoint(x: 5.49, y: 34.35), in: rect))
        personColor.setStroke()
        bezier2Path.lineWidth = lineWidth
        bezier2Path.stroke()
        
        context!.restoreGState()
        
        // Leg A
        context!.saveGState()
        context!.translateBy(x: 32.5 / paintCodeWidth * rect.width, y: 72.5 / paintCodeHeight * rect.height)
        context!.rotate(by: -legA * .pi / 180)
        
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: correct(CGPoint(x: 1, y: -1), in: rect))
        bezier3Path.addLine(to: correct(CGPoint(x: -5, y: 17), in: rect))
        bezier3Path.addLine(to: correct(CGPoint(x: -30, y: 14), in: rect))
        personColor.setStroke()
        bezier3Path.lineWidth = lineWidth
        bezier3Path.stroke()
        
        context!.restoreGState()
        
        // Arm B
        context!.saveGState()
        context!.translateBy(x: 32.02 / paintCodeWidth * rect.width, y: 41.59 / paintCodeHeight * rect.height)
        context!.rotate(by: -armB * .pi / 180)
        
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: correct(CGPoint(x: 0.48, y: -2.09), in: rect))
        bezier4Path.addLine(to: correct(CGPoint(x: 13.48, y: 8.91), in: rect))
        bezier4Path.addLine(to: correct(CGPoint(x: 30.48, y: -8.09), in: rect))
        personColor.setStroke()
        bezier4Path.lineWidth = lineWidth
        bezier4Path.stroke()
        
        context!.restoreGState()
        
        // Arm A
        context!.saveGState()
        context!.translateBy(x: 32.02 / paintCodeWidth * rect.width, y: 41.59 / paintCodeHeight * rect.height)
        context!.rotate(by: -armA * .pi / 180)
        
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: correct(CGPoint(x: -1.02, y: -1.18), in: rect))
        bezier5Path.addLine(to: correct(CGPoint(x: 11.98, y: 9.82), in: rect))
        bezier5Path.addLine(to: correct(CGPoint(x: 28.98, y: -7.18), in: rect))
        personColor.setStroke()
        bezier5Path.lineWidth = lineWidth
        bezier5Path.stroke()
        
        context!.restoreGState()
    }
    
    func correct(_ point: CGPoint, in rect: CGRect) -> CGPoint {
        let correctedX = point.x / paintCodeWidth * rect.width
        let correctedY = point.y / paintCodeHeight * rect.height
        return CGPoint(x: correctedX, y: correctedY)
    }
}
