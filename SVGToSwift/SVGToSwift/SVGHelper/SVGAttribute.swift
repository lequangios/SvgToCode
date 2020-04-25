//
//  SVGAttribute.swift
//  SVGToSwift
//
//  Created by Le Viet Quang on 10/13/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

let rootValue = -100

enum LanguageName : String {
    case Swift = "Swift"
    case Obj = "Objective-C"
    case Js = "Javascript Canvas"
    
    func all() -> [LanguageName] {
        return [LanguageName.Swift];
    }
    
    func type()->CodeMaker{
        switch self {
        case .Swift:
            return SwiftCode() as CodeMaker
        case .Obj:
            return ObjCode() as CodeMaker
        case .Js:
            return JSCode() as CodeMaker
        }
    }
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
    case radialGradient = "radialGradient"
    case rect           = "rect"
    case style          = "style"
    case unsuported     = "unsuported"
    case parselater     = "parselater"
    case mask           = "mask"
    
    func alls()->[SVGElementName] {
        return [SVGElementName.svg, SVGElementName.circle, SVGElementName.clipPath, SVGElementName.defs, SVGElementName.ellipse, SVGElementName.g, SVGElementName.glyph, SVGElementName.line, SVGElementName.path, SVGElementName.polygon, SVGElementName.polyline, SVGElementName.radialGradient, SVGElementName.rect,  SVGElementName.style];
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


