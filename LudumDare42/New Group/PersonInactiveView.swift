//
//  PersonInactiveView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/11/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

@IBDesignable
class PersonInactiveView: UIView {
    static let aspectRatio: CGFloat = 1.935
    
    // Declarations
    @IBInspectable var personColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var bedframe = UIColor(red: 0.625, green: 0.436, blue: 0.436, alpha: 1.000)
    @IBInspectable var blanket: UIColor = UIColor(red: 0.481, green: 0.546, blue: 0.672, alpha: 1.000)
    @IBInspectable var lineWidth: CGFloat = 3
    
    // Context
    let paintCodeWidth: CGFloat = 120
    let paintCodeHeight: CGFloat = 62
    
    override func draw(_ rect: CGRect) {
        // Bed Drawing
        let rectanglePath = UIBezierPath(rect: correct(CGRect(x: 2, y: 40, width: 116, height: 4), in: rect))
        bedframe.setFill()
        rectanglePath.fill()
        let rectangle2Path = UIBezierPath(rect: correct(CGRect(x: 2, y: 42, width: 4, height: 20), in: rect))
        bedframe.setFill()
        rectangle2Path.fill()
        let rectangle3Path = UIBezierPath(rect: correct(CGRect(x: 114, y: 42, width: 4, height: 20), in: rect))
        bedframe.setFill()
        rectangle3Path.fill()
        
        // Head Drawing
        let ovalPath = UIBezierPath(ovalIn: correct(CGRect(x: 2, y: 16, width: 25, height: 24), in: rect))
        personColor.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.stroke()
        
        // Blanket Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: correct(CGPoint(x: 25.5, y: 42.5), in: rect))
        bezierPath.addLine(to: correct(CGPoint(x: 25.5, y: 12.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 40.5, y: 4.5), in: rect), controlPoint1: correct(CGPoint(x: 25.5, y: 12.5), in: rect), controlPoint2: correct(CGPoint(x: 31.5, y: 4.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 59.5, y: 12.5), in: rect), controlPoint1: correct(CGPoint(x: 49.5, y: 4.5), in: rect), controlPoint2: correct(CGPoint(x: 59.5, y: 12.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 73.5, y: 12.5), in: rect), controlPoint1: correct(CGPoint(x: 59.5, y: 12.5), in: rect), controlPoint2: correct(CGPoint(x: 62.5, y: 16.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 98.5, y: 1.5), in: rect), controlPoint1: correct(CGPoint(x: 84.5, y: 8.5), in: rect), controlPoint2: correct(CGPoint(x: 90.5, y: 1.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 114.5, y: 12.5), in: rect), controlPoint1: correct(CGPoint(x: 106.5, y: 1.5), in: rect), controlPoint2: correct(CGPoint(x: 114.5, y: 12.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 118.5, y: 42.5), in: rect), controlPoint1: correct(CGPoint(x: 114.5, y: 12.5), in: rect), controlPoint2: correct(CGPoint(x: 118.5, y: 39.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 65.5, y: 42.5), in: rect), controlPoint1: correct(CGPoint(x: 118.5, y: 45.5), in: rect), controlPoint2: correct(CGPoint(x: 65.5, y: 42.5), in: rect))
        bezierPath.addLine(to: correct(CGPoint(x: 25.5, y: 42.5), in: rect))
        bezierPath.close()
        blanket.setFill()
        bezierPath.fill()
        personColor.setStroke()
        bezierPath.lineWidth = lineWidth
        bezierPath.stroke()
    }
    
    func correct(_ correct: CGRect, in rect: CGRect) -> CGRect {
        let correctedX = correct.minX / paintCodeWidth * rect.width
        let correctedY = correct.minY / paintCodeHeight * rect.height
        let correctedWidth = correct.width / paintCodeWidth * rect.width
        let correctedHeight = correct.height / paintCodeHeight * rect.height
        return CGRect(x: correctedX, y: correctedY, width: correctedWidth, height: correctedHeight)
    }
    
    func correct(_ point: CGPoint, in rect: CGRect) -> CGPoint {
        let correctedX = point.x / paintCodeWidth * rect.width
        let correctedY = point.y / paintCodeHeight * rect.height
        return CGPoint(x: correctedX, y: correctedY)
    }
}
