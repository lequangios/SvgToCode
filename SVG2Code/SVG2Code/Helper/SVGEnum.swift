//
//  SVGEnum.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

typealias SVGCircle = (center:CGPoint, radius:Double)
typealias SVGRect = CGRect
typealias SVGClipPath = (id:String, clipPathUnits:String)
typealias SVGEllipse = (point:CGPoint, rx:Double, ry:Double)
typealias SVGLine = (p1:CGPoint, p2:CGPoint)
typealias SVGPolyline = [CGPoint]
typealias SVGRadialGradient = (colors:[String], locations:[NSNumber], point:CGPoint, radius:Double)
typealias SVGUse = (href:String, p:CGPoint, size:CGSize)
typealias SVGText = (point:CGPoint, text:String)
typealias SVG = (viewbox:CGRect, viewport:CGRect)

enum StylePriority:Int {
    case ElementAttribute = 4
    case ElementClass = 3
    case ParentElementAttribute = 2
    case ParentElementClass = 1
}

enum SVGElementName:String {
    case svg            = "svg"
    case circle         = "circle"
    case clipPath       = "clipPath"
    case defs           = "defs"
    case ellipse        = "ellipse"
    case g              = "g"
    case glyph          = "glyph"
    case line           = "line"
    case path           = "path"
    case polygon        = "polygon"
    case polyline       = "polyline"
    case pattern        = "pattern"
    case text           = "text"
    case radialGradient = "radialGradient"
    case rect           = "rect"
    case use            = "use"
    case style          = "style"
    case unsuported     = "unsuported"
    case parselater     = "parselater"
    case mask           = "mask"
    
    func alls()->[SVGElementName] {
        return [SVGElementName.svg, SVGElementName.circle, SVGElementName.clipPath, SVGElementName.defs, SVGElementName.ellipse, SVGElementName.g, SVGElementName.glyph, SVGElementName.line, SVGElementName.path, SVGElementName.polygon, SVGElementName.polyline, SVGElementName.radialGradient, SVGElementName.rect,  SVGElementName.style, SVGElementName.pattern, SVGElementName.text, SVGElementName.use];
    }
    
    func isShape() -> Bool {
        return self == .g || self == .svg || self == .glyph || self == .radialGradient || self == .text || self == .use || self == .clipPath || self == .defs
    }
    
    func isPath() -> Bool {
        let value = self == .rect || self == .path || self == .circle || self == .ellipse || self == .line || self == .polygon || self == .polyline
        return value
    }
    
    func priority() -> Int {
        if isPath() { return 1 }
        else if isShape() { return 1 }
        else { return -1 }
    }
    
    func support()->[SVGElementName] {
        return [SVGElementName.svg]
    }
}

enum SVGAttributeName:String {
    case class_css          = "class"
    case clip_path          = "clip-path"
    case clip               = "clip"
    case color              = "color"
    case fill               = "fill"
    case fill_opacity       = "fill-opacity"
    case fill_rule          = "fill-rule"
    case id                 = "id"
    case stroke             = "stroke"
    case stroke_dasharray   = "stroke-dasharray"
    case stroke_dashoffset  = "stroke-dashoffset"
    case stroke_linecap     = "stroke-linecap"
    case stroke_linejoin    = "stroke-linejoin"
    case stroke_miterlimit  = "stroke-miterlimit"
    case stroke_opacity     = "stroke-opacity"
    case stroke_width       = "stroke-width"
    case style              = "style"
    case opacity            = "opacity"
    
    func all() -> [SVGAttributeName] {
        return [SVGAttributeName.class_css, SVGAttributeName.clip_path, SVGAttributeName.clip, SVGAttributeName.color, SVGAttributeName.fill, SVGAttributeName.fill_opacity, SVGAttributeName.fill_rule, SVGAttributeName.id, SVGAttributeName.stroke, SVGAttributeName.stroke_dasharray, SVGAttributeName.stroke_dashoffset, SVGAttributeName.stroke_linecap, SVGAttributeName.stroke_linejoin, SVGAttributeName.stroke_miterlimit, SVGAttributeName.stroke_opacity, SVGAttributeName.stroke_width, SVGAttributeName.style, SVGAttributeName.opacity]
    }
}
