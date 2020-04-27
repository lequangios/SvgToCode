//
//  ShapeStyleModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/26/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import CoreGraphics
import QuartzCore

struct ShapeStyleModel {
    var name:String?
    var fillColor:String?
    var fillRule:(CAShapeLayerFillRule, Bool) = (.nonZero, true)
    var lineCap:(CAShapeLayerLineCap, Bool)   = (.butt, true)
    var lineDashPhase:(CGFloat, Bool)         = (0, true)
    var lineJoin:(CAShapeLayerLineJoin, Bool) = (.miter, true)
    var lineWidth:(CGFloat, Bool)             = (1, true)
    var miterLimit:(CGFloat, Bool)            = (10, true)
    var strokeColor:String?
    var strokeStart:(CGFloat, Bool)           = (0, true)
    var strokeEnd:(CGFloat, Bool)             = (1, true)
    var opacity:(CGFloat, Bool)               = (1, true)

    var isFillByShape:Bool = false
    var shapeFillId:String = ""
    var priority:Int = 0
    
    init() {
        
    }
    
    init(_ element:XML.Element, _ priority:Int) {
        if let opacity = element.attributes["opacity"]{
            self.opacity = (CGFloat(opacity.doubleValue), false)
        }
        
        if let fill = element.attributes["fill"] {
            // Check if it is shape
            let shapes = fill.split(separator: "(")
            if shapes.count >= 2 {
                self.isFillByShape = true
                self.shapeFillId = String(shapes[1]).replacingOccurrences(of: ")", with: "")
            }
            else {
                self.fillColor = fill.trim("#")
            }
        }
        
        if let fill_rule = element.attributes["fill-rule"] {
            if fill_rule == "evenodd" {
                self.fillRule = (.evenOdd, false)
            }
        }
        
        if let line_cap = element.attributes["stroke-linecap"] {
            if line_cap == "round" {
                self.lineCap = (.round, false)
            }
            else if line_cap == "square" {
                self.lineCap = (.square, false)
            }
        }
        
        if let line_join = element.attributes["stroke-linejoin"] {
            if line_join == "bevel" {
                self.lineJoin = (.bevel, false)
            }
            else if line_join == "round" {
                self.lineJoin = (.round, false)
            }
        }
        
        if let name = element.attributes["name"]{
            self.name = name
        }
        
        if let line_width = element.attributes["stroke-width"] {
            self.lineWidth = (CGFloat(line_width.doubleValue), false)
        }
        
        if let miter_limit = element.attributes["stroke-miterlimit"] {
            self.miterLimit = (CGFloat(miter_limit.doubleValue), false)
        }
        
        if let stroke_color = element.attributes["stroke"] {
            self.strokeColor = stroke_color.trim("#")
        }
        
        self.priority = priority
    }
    
    init(_ style:SVGStyleElement, _ priority:Int) {
        if let opacity = style.properties?["opacity"]?.value {
                self.opacity = (CGFloat(opacity.doubleValue), false)
            }
            
        if let fill = style.properties?["fill"]?.value {
            // Check if it is shape
            let shapes = fill.split(separator: "(")
            if shapes.count >= 2 {
                self.isFillByShape = true
                self.shapeFillId = String(shapes[1]).replacingOccurrences(of: ")", with: "")
            }
            else {
                self.fillColor = fill
            }
        }
            
        if let fill_rule = style.properties?["fill-rule"]?.value  {
            if fill_rule == "evenodd" {
                self.fillRule = (.evenOdd, false)
            }
        }
            
        if let line_cap = style.properties?["stroke-linecap"]?.value {
            if line_cap == "round" {
                self.lineCap = (.round, false)
            }
            else if line_cap == "square" {
                self.lineCap = (.square, false)
            }
        }
            
        if let line_join = style.properties?["stroke-linejoin"]?.value {
            if line_join == "bevel" {
                self.lineJoin = (.bevel, false)
            }
            else if line_join == "round" {
                self.lineJoin = (.round, false)
            }
        }
            
        if let line_width = style.properties?["stroke-width"]?.value {
                self.lineWidth = (CGFloat(line_width.doubleValue), false)
            }
            
        if let miter_limit = style.properties?["stroke-miterlimit"]?.value {
            self.miterLimit = (CGFloat(miter_limit.doubleValue), false)
        }
            
        if let stroke_color = style.properties?["stroke"]?.value {
            self.strokeColor = stroke_color
        }
        
        self.priority = priority
    }
}

extension Array where Element == ShapeStyleModel {
    func getLastStyle()->ShapeStyleModel {
        let list = self.sorted(by: {$0.priority < $1.priority})
        var shapeStyle = list.first ?? ShapeStyleModel()
        for item in list {
            if shapeStyle.fillColor == nil && item.fillColor != nil { shapeStyle.fillColor = item.fillColor }
            if shapeStyle.strokeColor == nil && item.strokeColor != nil { shapeStyle.strokeColor = item.strokeColor }
            if (shapeStyle.fillRule.1 == true && item.fillRule.1 == false) { shapeStyle.fillRule = item.fillRule }
            if shapeStyle.lineCap.1 == true && item.lineCap.1 == false { shapeStyle.lineCap = item.lineCap}
            if shapeStyle.lineDashPhase.1 == true && item.lineDashPhase.1 == false { shapeStyle.lineDashPhase = item.lineDashPhase }
            if shapeStyle.lineJoin.1 == true && item.lineJoin.1 == false { shapeStyle.lineJoin = item.lineJoin }
            if shapeStyle.lineWidth.1 == true && item.lineWidth.1 == false { shapeStyle.lineWidth = item.lineWidth }
            if shapeStyle.miterLimit.1 == true && item.miterLimit.1 == false { shapeStyle.miterLimit = item.miterLimit }
            if shapeStyle.strokeStart.1 == true && item.strokeStart.1 == false { shapeStyle.strokeStart = item.strokeStart }
            if shapeStyle.strokeEnd.1 == true && item.strokeEnd.1 == false { shapeStyle.strokeEnd = item.strokeEnd }
            if shapeStyle.opacity.1 == true && item.opacity.1 == false { shapeStyle.opacity = item.opacity }
        }
        
        return shapeStyle
    }
}
