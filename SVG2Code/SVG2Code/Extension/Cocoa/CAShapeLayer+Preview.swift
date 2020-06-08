//
//  CAShapeLayer+Preview.swift
//  SVG2Code
//
//  Created by Le Quang on 5/12/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa

extension  CAShapeLayer {
    func applyAttribute(attribute:SVGElementAttribute) {
        if let fillColor = attribute.fillColor {
            fill("#\(fillColor)")
        }
        
        if let nameStr = attribute.name {
            name = nameStr
        }
        
        if attribute.fillRule.0 != .nonZero {
            fillRule = .evenOdd
        }
        
        if attribute.lineCap.0 != .butt {
            if attribute.lineCap.0 == .round {
                lineCap = .round
            }
            else if attribute.lineCap.0 == .square {
                lineCap = .square
            }
        }
        
        if attribute.lineDashPhase.0 != 0 {
            lineDashPhase = attribute.lineDashPhase.0
        }
        
        if attribute.lineJoin.0 != .miter {
            if attribute.lineJoin.0 == .bevel {
                lineJoin = .bevel
            }
            else  if attribute.lineJoin.0 == .round {
                lineJoin = .round
            }
        }
        
        if attribute.lineWidth.0 != 1 {
            lineWidth = attribute.lineWidth.0
        }
        
        if attribute.miterLimit.0 != 10 {
            miterLimit = attribute.miterLimit.0
        }
        
        if let strokeColor = attribute.strokeColor {
            self.strokeColor = "#\(strokeColor)".colorValue.cgColor
        }
        
        if attribute.opacity.0 != 1 {
            opacity = Float(attribute.opacity.0)
        }
    }
}
