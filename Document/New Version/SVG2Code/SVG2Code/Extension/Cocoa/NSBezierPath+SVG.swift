//
//  NSBezierPath+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa

extension CGPoint {
    var point:NSPoint { return NSPoint(x: x, y: y)}
    
    func toBottom(height:Double) -> NSPoint {
        return NSPoint(x: x, y: CGFloat(height)-y)
    }
}

extension CGRect {
    var rect:NSRect { return NSRect(origin: origin, size: size) }
    
    func toBottom(height:Double) -> NSRect {
        let newPoint = origin.toBottom(height: height)
        return NSRect(origin: newPoint, size: size)
    }
}

extension NSBezierPath {
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
                break
            case .lineTo:
                path.addLine(to: points[0])
                break
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
                break
            case .closePath:
                path.closeSubpath()
                break
            @unknown default:
                print("unkown \(type.rawValue)")
            }
        }
        return path
    }
    
    convenience init(ellipse center:CGPoint, rx:CGFloat, ry:CGFloat){
        let rect = CGRect.init(x: center.x - rx, y: center.y - ry, width: rx, height: ry)
        self.init(ovalIn: rect)
    }
    
    convenience init(circle center:NSPoint, radius:CGFloat) {
        self.init()
        appendArc(withCenter: center, radius: radius, startAngle: 0, endAngle: -2*CGFloat.pi, clockwise: true)
    }
    
    convenience init(line point1:NSPoint, point2:NSPoint){
        self.init()
        self.move(to: point1)
        self.line(to: point2)
    }
    
    func fillWithHex(_ hexColor:String){
        hexColor.colorValue.setFill()
        self.fill()
    }
    
    func strokeWithHex(_ hexColor:String){
        hexColor.colorValue.setStroke()
        self.stroke()
    }
    
    func quadCurve(to endPoint: NSPoint, controlPoint: NSPoint){
        let startPoint = self.currentPoint
        let controlPoint1 = CGPoint(x: (startPoint.x + (controlPoint.x - startPoint.x) * 2.0/3.0), y: (startPoint.y + (controlPoint.y - startPoint.y) * 2.0/3.0))
        let controlPoint2 = CGPoint(x: (endPoint.x + (controlPoint.x - endPoint.x) * 2.0/3.0), y: (endPoint.y + (controlPoint.y - endPoint.y) * 2.0/3.0))
        curve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
    
    func addQuadCurve(to endPoint: CGPoint, controlPoint: CGPoint){
        let startPoint = self.currentPoint
        let controlPoint1 = CGPoint(x: (startPoint.x + (controlPoint.x - startPoint.x) * 2.0/3.0), y: (startPoint.y + (controlPoint.y - startPoint.y) * 2.0/3.0))
        let controlPoint2 = CGPoint(x: (endPoint.x + (controlPoint.x - endPoint.x) * 2.0/3.0), y: (endPoint.y + (controlPoint.y - endPoint.y) * 2.0/3.0))
        curve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
    
}
