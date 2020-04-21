//
//  PathAttributeModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/17/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore

struct PathAttributeModel {
    var lineWidth: CGFloat = 1.0
    var lineCapStyle: CGLineCap = .butt
    var lineJoinStyle: CGLineJoin = .miter
    var miterLimit: CGFloat = 10
    var flatness: CGFloat = 0.6
    var usesEvenOddFillRule: Bool = false
    var opacity:CGFloat = 1.0
    var strokeColor:String?
    var fillColor:String?
    
    init(_ attribute:PathAttributeModel) {
        self.lineWidth = attribute.lineWidth
        self.lineCapStyle = attribute.lineCapStyle
        self.lineJoinStyle = attribute.lineJoinStyle
        self.miterLimit = attribute.miterLimit
        self.flatness = attribute.flatness
        self.usesEvenOddFillRule = attribute.usesEvenOddFillRule
        self.opacity = attribute.opacity
        self.strokeColor = attribute.strokeColor
        self.fillColor = attribute.fillColor
    }
    
    init() {
        
    }
       
    init(_ model:SVGDataModel){
        if let line_cap = model.element.attributes["stroke-linecap"] {
            if line_cap == "round" { self.lineCapStyle = .round }
            else if line_cap == "square" { self.lineCapStyle = .square }
        }
        
        if let line_width = model.element.attributes["stroke-width"] {
            self.lineWidth = CGFloat(line_width.doubleValue)
        }
        
        if let line_join = model.element.attributes["stroke-linejoin"] {
            if line_join == "bevel" { self.lineJoinStyle = .bevel }
            else if line_join == "round" { self.lineJoinStyle = .round }
        }
        
        if let miter_limit = model.element.attributes["stroke-miterlimit"] {
            self.miterLimit = CGFloat(miter_limit.doubleValue)
        }
        
        if let fill_rule = model.element.attributes["fill-rule"], fill_rule == "evenodd" { self.usesEvenOddFillRule = true }
        
        if let opacity = model.element.attributes["opacity"] {
            self.opacity = CGFloat(opacity.doubleValue)
        }
        
        if let stroke = model.element.attributes["stroke"] {
            self.strokeColor = stroke
        }
        
        if let fill = model.element.attributes["fill"] {
            self.fillColor = fill
        }
    }
    
    init(_ model:SVGDataModel, attribute:PathAttributeModel) {
        self.init(attribute)
        if let line_cap = model.element.attributes["stroke-linecap"] {
            if line_cap == "round" { self.lineCapStyle = .round }
            else if line_cap == "square" { self.lineCapStyle = .square }
        }
        
        if let line_width = model.element.attributes["stroke-width"] {
            self.lineWidth = CGFloat(line_width.doubleValue)
        }
        
        if let line_join = model.element.attributes["stroke-linejoin"] {
            if line_join == "bevel" { self.lineJoinStyle = .bevel }
            else if line_join == "round" { self.lineJoinStyle = .round }
        }
        
        if let miter_limit = model.element.attributes["stroke-miterlimit"] {
            self.miterLimit = CGFloat(miter_limit.doubleValue)
        }
        
        if let fill_rule = model.element.attributes["fill-rule"], fill_rule == "evenodd" { self.usesEvenOddFillRule = true }
        
        if let opacity = model.element.attributes["opacity"] {
            self.opacity = CGFloat(opacity.doubleValue)
        }
        
        if let stroke = model.element.attributes["stroke"] {
            self.strokeColor = stroke
        }
        
        if let fill = model.element.attributes["fill"] {
            self.fillColor = fill
        }
    }
}
