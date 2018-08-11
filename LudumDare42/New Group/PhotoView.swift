//
//  PhotoView.swift
//  LudumDare42
//
//  Created by Nathan Tornquist on 8/10/18.
//  Copyright © 2018 nathantornquist. All rights reserved.
//

import UIKit

@IBDesignable
class PhotoView: UIView {
    static let aspectRatio: CGFloat = 1
    
    // Color Declarations
    let photoBackground = UIColor(red: 0.464, green: 0.754, blue: 0.948, alpha: 1.000)
    let photoForeground = UIColor(red: 0.320, green: 0.800, blue: 0.626, alpha: 1.000)
    
    // Context
    let paintCodeWidth: CGFloat = 100
    let paintCodeHeight: CGFloat = 100
    
    @IBInspectable var lineWidth: CGFloat = 3
    
    override func draw(_ rect: CGRect) {
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: lineWidth/2, y: lineWidth/2, width: rect.width-lineWidth, height: rect.height-lineWidth))
        photoBackground.setFill()
        rectanglePath.fill()
        UIColor.black.setStroke()
        rectanglePath.lineWidth = lineWidth
        rectanglePath.stroke()
        
        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: correct(CGPoint(x: lineWidth/2, y: 59.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 19.5, y: 56.5), in: rect), controlPoint1: correct(CGPoint(x: 2.5, y: 59.5), in: rect), controlPoint2: correct(CGPoint(x: 12.5, y: 60.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 38.5, y: 45.5), in: rect), controlPoint1: correct(CGPoint(x: 26.5, y: 52.5), in: rect), controlPoint2: correct(CGPoint(x: 30.5, y: 42.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 57.5, y: 64.5), in: rect), controlPoint1: correct(CGPoint(x: 46.5, y: 48.5), in: rect), controlPoint2: correct(CGPoint(x: 44.5, y: 69.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 80.5, y: 76.5), in: rect), controlPoint1: correct(CGPoint(x: 70.5, y: 59.5), in: rect), controlPoint2: correct(CGPoint(x: 70.5, y: 76.5), in: rect))
        bezierPath.addCurve(to: correct(CGPoint(x: 98.5, y: 59.5), in: rect), controlPoint1: correct(CGPoint(x: 90.5, y: 76.5), in: rect), controlPoint2: correct(CGPoint(x: 98.5, y: 59.5), in: rect))
        bezierPath.addLine(to: correct(CGPoint(x: 98.5, y: 98.5), in: rect))
        bezierPath.addLine(to: correct(CGPoint(x: lineWidth/2, y: 98.5), in: rect))
        bezierPath.addLine(to: correct(CGPoint(x: lineWidth/2, y: 59.5), in: rect))
        photoForeground.setFill()
        bezierPath.fill()
        UIColor.black.setStroke()
        bezierPath.lineWidth = lineWidth
        bezierPath.stroke()
    }
    
    func correct(_ point: CGPoint, in rect: CGRect) -> CGPoint {
        let correctedX = point.x / paintCodeWidth * rect.width
        let correctedY = point.y / paintCodeHeight * rect.height
        return CGPoint(x: correctedX, y: correctedY)
    }
}
