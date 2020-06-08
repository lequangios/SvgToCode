//
//  CAShapeLayer+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa

extension  CAShapeLayer {
    func fill(_ hexColor:String){
        self.fillColor = hexColor.colorValue.cgColor
    }
    
    func check(contain point:NSPoint, isIgnorePosition:Bool = true) {
        let zIndex = zPosition
        if isIgnorePosition == true { zPosition = 0.0 }
        if let path = self.path {
            if path.contains(point, using: .evenOdd, transform: .identity) { isfocus = 1 }
            else { isfocus = 0 }
        }
        else { isfocus = 0 }
        zPosition = zIndex
    }
    
    func apply(alpha:CGFloat) {
        if let cg = fillColor, let color = NSColor(cgColor: cg), color != .clear {
            fillColor = color.withAlphaComponent(alpha).cgColor
        }
    }

}

extension CAGradientLayer {
    
}
