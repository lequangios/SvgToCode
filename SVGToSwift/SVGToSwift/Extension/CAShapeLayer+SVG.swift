//
//  CAShapeLayer+SVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 5/2/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa

extension  CAShapeLayer {
    
    func check(contain point:NSPoint) {
        if let path = self.path {
            if path.contains(point, using: .winding, transform: .identity) { isfocus = 1 }
        }
        isfocus = 0
    }
    
    func applyShapeStyle(_ model:SVGDataModel, _ style:StyleSheet){
        let shapeStyle = model.getStyleList(style).getLastStyle()
        applyStyle(shapeStyle)
    }
    
    func applyStyle(_ shapeStyle:ShapeStyleModel) {
        if let fillColor = shapeStyle.fillColor {
            fill("#\(fillColor)")
        }
        
        if let nameStr = shapeStyle.name {
            name = nameStr
        }
        
        if shapeStyle.fillRule.0 != .nonZero {
            fillRule = .evenOdd
        }
        
        if shapeStyle.lineCap.0 != .butt {
            if shapeStyle.lineCap.0 == .round {
                lineCap = .round
            }
            else if shapeStyle.lineCap.0 == .square {
                lineCap = .square
            }
        }
        
        if shapeStyle.lineDashPhase.0 != 0 {
            lineDashPhase = shapeStyle.lineDashPhase.0
        }
        
        if shapeStyle.lineJoin.0 != .miter {
            if shapeStyle.lineJoin.0 == .bevel {
                lineJoin = .bevel
            }
            else  if shapeStyle.lineJoin.0 == .round {
                lineJoin = .round
            }
        }
        
        if shapeStyle.lineWidth.0 != 1 {
            lineWidth = shapeStyle.lineWidth.0
        }
        
        if shapeStyle.miterLimit.0 != 10 {
            miterLimit = shapeStyle.miterLimit.0
        }
        
        if let strokeColor = shapeStyle.strokeColor {
            self.strokeColor = "#\(strokeColor)".colorValue.cgColor
        }
        
        if shapeStyle.opacity.0 != 1 {
            opacity = Float(shapeStyle.opacity.0)
        }
    }
}

extension CAGradientLayer {
    func applyStyle(_ shapeStyle:ShapeStyleModel) {
        func applyShapeStyle(_ model:SVGDataModel, _ style:StyleSheet){
            let shapeStyle = model.getStyleList(style).getLastStyle()
            applyStyle(shapeStyle)
        }
        
        if let nameStr = shapeStyle.name {
            name = nameStr
        }
        
        if shapeStyle.opacity.0 != 1 {
            opacity = Float(shapeStyle.opacity.0)
        }
    }
}
