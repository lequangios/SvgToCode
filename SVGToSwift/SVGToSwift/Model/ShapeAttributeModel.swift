//
//  ShapeAttributeModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/17/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore

struct ShapeAttributeModel {
    var name:String?
    var fillColor:String?
    var fillRule:CAShapeLayerFillRule = .nonZero
    var lineCap:CAShapeLayerLineCap = .butt
    var lineDashPhase:CGFloat = 0
    var lineJoin:CAShapeLayerLineJoin = .miter
    var lineWidth:CGFloat = 1
    var miterLimit:CGFloat = 10
    var strokeColor:String?
    var strokeStart:CGFloat = 0
    var strokeEnd:CGFloat = 1.0
    var opacity:CGFloat = 1.0
    
    var isFillByShape:Bool = false
    var shapeFillId:String = ""
    var isDefault:Bool = true
    var priority:Int = 0
    
    init(_ attribute:ShapeAttributeModel) {
        self.fillColor = attribute.fillColor
        self.fillRule = attribute.fillRule
        self.lineCap = attribute.lineCap
        self.lineDashPhase = attribute.lineDashPhase
        self.lineJoin = attribute.lineJoin
        self.lineWidth = attribute.lineWidth
        self.miterLimit = attribute.miterLimit
        self.strokeColor = attribute.strokeColor
        self.strokeStart = attribute.strokeStart
        self.strokeEnd = attribute.strokeEnd
        self.opacity = attribute.opacity
        self.name = attribute.name
        
        self.isFillByShape = attribute.isFillByShape
        self.shapeFillId = attribute.shapeFillId
    }
    
    init() {
        
    }
    
    init(_ model:SVGDataModel) {
        if let opacity = model.element.attributes["opacity"] {
            self.opacity = CGFloat(opacity.doubleValue)
        }
        
        if let fill = model.element.attributes["fill"] {
            // Check if it is shape
            let shapes = fill.split(separator: "(")
            if shapes.count >= 2 {
                self.isFillByShape = true
                self.shapeFillId = String(shapes[1]).replacingOccurrences(of: ")", with: "")
            }
            else {
                self.fillColor = fill.trim("#")
            }
            self.isDefault = false
        }
        
        if let fill_rule = model.element.attributes["fill-rule"] {
            if fill_rule == "nonzero" {
                self.fillRule = .nonZero
            }
            else if fill_rule == "evenodd" {
                self.fillRule = .evenOdd
            }
            self.isDefault = false
        }
        
        if let line_cap = model.element.attributes["stroke-linecap"] {
            if line_cap == "round" {
                self.lineCap = .round
            }
            else if line_cap == "square" {
                self.lineCap = .square
            }
            self.isDefault = false
        }
        
        if let line_join = model.element.attributes["stroke-linejoin"] {
            if line_join == "bevel" {
                self.lineJoin = .bevel
            }
            else if line_join == "round" {
                self.lineJoin = .round
            }
            self.isDefault = false
        }
        
        if let line_width = model.element.attributes["stroke-width"] {
            self.lineWidth = CGFloat(line_width.doubleValue)
            self.isDefault = false
        }
        
        if let miter_limit = model.element.attributes["stroke-miterlimit"] {
            self.miterLimit = CGFloat(miter_limit.doubleValue)
            self.isDefault = false
        }
        
        if let stroke_color = model.element.attributes["stroke"] {
            self.strokeColor = stroke_color.trim("#")
            self.isDefault = false
        }
    }
    
    init(_ model:SVGDataModel, attribute:ShapeAttributeModel) {
        self.init(attribute)
        if let opacity = model.element.attributes["opacity"] {
            self.opacity = CGFloat(opacity.doubleValue)
            self.isDefault = false
        }
        
        if let name = model.element.attributes["name"]{
            self.name = name
            self.isDefault = false
        }
        
        if let fill = model.element.attributes["fill"] {
            // Check if it is shape
            let shapes = fill.split(separator: "(")
            if shapes.count >= 2 {
                self.isFillByShape = true
                self.shapeFillId = String(shapes[1]).replacingOccurrences(of: ")", with: "")
            }
            else {
                self.fillColor = fill.trim("#")
            }
            self.isDefault = false
        }
        
        if let fill_rule = model.element.attributes["fill-rule"] {
            if fill_rule == "nonzero" {
                self.fillRule = .nonZero
            }
            else if fill_rule == "evenodd" {
                self.fillRule = .evenOdd
            }
            self.isDefault = false
        }
        
        if let line_cap = model.element.attributes["stroke-linecap"] {
            if line_cap == "round" {
                self.lineCap = .round
            }
            else if line_cap == "square" {
                self.lineCap = .square
            }
            self.isDefault = false
        }
        
        if let line_join = model.element.attributes["stroke-linejoin"] {
            if line_join == "bevel" {
                self.lineJoin = .bevel
            }
            else if line_join == "round" {
                self.lineJoin = .round
            }
            self.isDefault = false
        }
        
        if let line_width = model.element.attributes["stroke-width"] {
            self.lineWidth = CGFloat(line_width.doubleValue)
            self.isDefault = false
        }
        
        if let miter_limit = model.element.attributes["stroke-miterlimit"] {
            self.miterLimit = CGFloat(miter_limit.doubleValue)
            self.isDefault = false
        }
        
        if let stroke_color = model.element.attributes["stroke"] {
            self.strokeColor = stroke_color.trim("#")
            self.isDefault = false
        }
    }
}
