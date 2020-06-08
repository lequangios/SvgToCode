//
//  Value+SVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 5/2/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

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


