//
//  QySVGTypes.swift
//  SVG2Code
//
//  Created by Le Quang on 6/11/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore
import AppKit

enum QySVGPattern : String {
    case fillRule = "(nonzero|evenodd)"
    case fontWeight = "(normal | bold | bolder | lighter | [0-9]+)"
    case lineCap = "(butt|round|square)"
    case lineJoin = "(arcs|bevel|miter|miter-clip|round)"
    case none = "(none|transparent)"
    case name = "(#?)([a-zA-Z0-9_]+)"
    case number = "([+-]*)([0-9.]+)"
    case hex3Color = "#[0-9A-Fa-f]{3}"
    case hex6Color = "#[0-9A-Fa-f]{6}"
    case rgbColor = "rgb\\(([0-9.]+)( )([0-9.]+)( )([0-9.]+)\\)"
    case rgbaColor = "rgba\\(([0-9.]+)( )([0-9.]+)( )([0-9.]+)( )([0-9.]+)\\)"
    case angle = "([+-]*)([0-9.]+)( )*(deg?|grad?|rad?)"
    case length = "([+-]*)([0-9.]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)"
    case lengthList = "(([+-]*)([0-9.]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?))|((([+-]*)([0-9.]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)( |,)){1,})"
    case percentage = "([+-]*)([0-9.]+)( )*(%)"
    case matrix = "matrix\\((([-+]*)([0-9.]+))([ ,]*)(([-+]*)([0-9.]+))([ ,]*)(([-+]*)([0-9.]+))([ ,]*)(([-+]*)([0-9.]+))([ ,]*)(([-+]*)([0-9.]+))([ ,]*)(([-+]*)([0-9.]+))([ ,]*)\\)"
    case translate = "translate\\(([+-]*)([0-9.]+)([ ,]*)(([+-]*)([0-9.]+))?\\)"
    case scale = "scale\\(([+-]*)([0-9.]+)([ ,]*)(([+-]*)([0-9.]+))?\\)"
    case spreadMethod = "(pad|reflect|repeat)"
    case rotate = "rotate\\(([+-]*)([0-9.]+)([ ,]*)(([+-]*)([0-9.]+)([ ,]*)){0,2}\\)"
    case skewX = "skewX\\(([+-]*)([0-9.]+)\\)"
    case skewY = "skewY\\(([+-]*)([0-9.]+)\\)"
    case textAnchor = "(start|middle|end)"
    case unit = "em|ex|px|in|cm|mm|pt|pc|%|deg|grad|rad"
    case url = "((url\\()([a-zA-Z0-9#]+)(\\)))"
    case urlValue = "([^\\(#])[0-9a-zA-Z_]+(?=\\))" // Example url(#wrapper) => wrapper
    case viewBox = "([0-9.+-]*)(,| )([0-9.+-]*)(,| )([0-9.+-]*)(,| )([0-9.+-]*)"
}

struct QySVGValuePriority : Equatable {
    var rawValue:Int
    static let inline:QySVGValuePriority = .init(rawValue: 999000)
    static let cssstyle:QySVGValuePriority = .init(rawValue: 997000)
    static let inherit:QySVGValuePriority = .init(rawValue: 997000)
    static let initial:QySVGValuePriority = .init(rawValue: 0)
}

enum QySVGValueType {
    case absolute
    case relative
}

struct QyMatchPaternResult {
    var range:NSRange
    var value:String
}

struct SVGRectBound : Equatable {
    var x,y,z,t : NSNumber
    static let zero : SVGRectBound = .init(x: 0, y: 0, z: 0, t: 0)
}

enum QyLengthUnit : String {
    case kUnknown = "unknown"
    case kNumber = ""
    case kPercentage = "%"
    case kEMS = "em"
    case kEXS = "ex"
    case kPX = "px"
    case kCM = "cm"
    case kMM = "mm"
    case kIN = "in"
    case kPT = "pt"
    case kPC = "pc"
}

protocol QySVGValue : QySVGAttributeValue, Comparable {
    associatedtype T
    var value:T {get set}
    init(rawValue:String, priority:QySVGValuePriority)
}

protocol QySVGClipPathProperties {
    
}

protocol QySVGPaintProperties {
    
}

protocol QySVGTransformProperties {
    
}

protocol QySVGAttributeValue {
    var priority:QySVGValuePriority {get set}
    var rawValue: String {get set}
    var type:QySVGValueType {get set}
    var unit:QyLengthUnit {get set}
    var isValid:Bool { get }
}

protocol QySVGPresentationAttributes{
    init?(rawValue:String)
}

struct QyShapeFunction {
    var name:String
    var validPattern:String
    var valuePattern:String
    static let none:QyShapeFunction = .init(name: "none", validPattern: "none", valuePattern: "")
    static let inset:QyShapeFunction = .init(name: "inset", validPattern: "((inset\\()(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,4})( )*(round)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,4}(\\))", valuePattern: "((([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,4})( )*(round)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,4}")
    static let circle:QyShapeFunction = .init(name: "circle", validPattern: "((circle\\()(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,1})( )*(at)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,2}(\\))", valuePattern: "((([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,1})( )*(at)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,2}")
    static let ellipse:QyShapeFunction = .init(name: "ellipse", validPattern: "((ellipse\\()(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){2,2})( )*(at)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,2}(\\))", valuePattern: "((([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){2,2})( )*(at)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?)){0,2}")
    static let polygon:QyShapeFunction = .init(name: "polygon", validPattern: "((polygon\\()(nonzero|evenodd)*(([+-]*)([0-9. ]+)( )*(em?|ex?|px?|in?|cm?|mm?|pt?|pc?|%?))+)(\\))", valuePattern: "")
    static let path:QyShapeFunction = .init(name: "path", validPattern: "(path\\()(nonzero|evenodd)*([a-zA-Z0-9\\n. +-]*)(\\))", valuePattern: "")
    static let url:QyShapeFunction = .init(name: "url", validPattern: "((url\\()([a-zA-Z0-9#]+)(\\)))", valuePattern: "([^\\(#])[0-9a-zA-Z_]+(?=\\))")
}

struct QySVGInsetShapeFunction : QySVGValue , QySVGClipPathProperties, QySVGAttributeValue{
    struct InsetShapeValue {
        var inset:SVGRectBound = .zero
        var round:SVGRectBound = .zero
        var insetUnit:QyLengthUnit = .kNumber
        var roundUnit:QyLengthUnit = .kNumber
        let shapeType:QyShapeFunction = .inset
        static let zero : InsetShapeValue = .init()
    }
    var rawValue:String
    var value:InsetShapeValue = .zero
    var type:QySVGValueType = .absolute
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: value.shapeType.validPattern) {
            
        }
        else { self.isValid = false }
    }
    
    static func < (lhs: QySVGInsetShapeFunction, rhs: QySVGInsetShapeFunction) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGInsetShapeFunction, rhs: QySVGInsetShapeFunction) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGInsetShapeFunction {
        return QySVGInsetShapeFunction(rawValue: rawValue, priority: priority)
    }
}

struct QySVGCircleShapeFunction : QySVGValue , QySVGClipPathProperties {
    struct CircleShapeValue {
        var radius:QySVGLengthValue
        var at:CGPoint = .zero
        var atUnit:QyLengthUnit = .kNumber
        let shapeType:QyShapeFunction = .circle
        static let zero : CircleShapeValue = .init(radius: .zero)
    }
    var rawValue:String
    var value:CircleShapeValue = .zero
    var type:QySVGValueType = .absolute
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: value.shapeType.validPattern) {
            
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGCircleShapeFunction, rhs: QySVGCircleShapeFunction) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGCircleShapeFunction, rhs: QySVGCircleShapeFunction) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGCircleShapeFunction {
        return QySVGCircleShapeFunction(rawValue: rawValue, priority: priority)
    }
}

struct QySVGEllipseShapeFunction : QySVGValue , QySVGClipPathProperties {
    struct EllipseShapeValue {
        var rx, ry : QySVGLengthValue
        var at:CGPoint = .zero
        var atUnit:QyLengthUnit = .kNumber
        let shapeType:QyShapeFunction = .ellipse
        static let zero:EllipseShapeValue = .init(rx: .zero, ry: .zero)
    }
    var rawValue:String
    var value:EllipseShapeValue = .zero
    var type:QySVGValueType = .absolute
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: value.shapeType.validPattern) {
            
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGEllipseShapeFunction, rhs: QySVGEllipseShapeFunction) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGEllipseShapeFunction, rhs: QySVGEllipseShapeFunction) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGEllipseShapeFunction {
        return QySVGEllipseShapeFunction(rawValue: rawValue, priority: priority)
    }
}

struct QySVGPolygonShapeFunction : QySVGValue , QySVGClipPathProperties {
    struct PolygonShapeValue {
        var points : [QySVGLengthValue]
        var fillRule : QySVGFillRuleValue
        let shapeType:QyShapeFunction = .polygon
        static let zero:PolygonShapeValue = .init(points: [], fillRule: .nonZero)
    }
    var rawValue:String
    var value:PolygonShapeValue = .zero
    var type:QySVGValueType = .absolute
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: value.shapeType.validPattern) {
            
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGPolygonShapeFunction, rhs: QySVGPolygonShapeFunction) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGPolygonShapeFunction, rhs: QySVGPolygonShapeFunction) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGPolygonShapeFunction {
        return QySVGPolygonShapeFunction(rawValue: rawValue, priority: priority)
    }
}

struct QySVGPathShapeFunction : QySVGValue , QySVGClipPathProperties {
    struct PathShapeValue {
        var points : [SVGCommand]
        var fillRule : QySVGFillRuleValue
        let shapeType:QyShapeFunction = .path
        static let zero:PathShapeValue = .init(points: [], fillRule: .nonZero)
    }
    var rawValue:String
    var value:PathShapeValue = .zero
    var type:QySVGValueType = .absolute
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: value.shapeType.validPattern) {
            
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGPathShapeFunction, rhs: QySVGPathShapeFunction) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGPathShapeFunction, rhs: QySVGPathShapeFunction) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGPathShapeFunction {
        return QySVGPathShapeFunction(rawValue: rawValue, priority: priority)
    }
}

struct QySVGBasicShape : QySVGValue {
    var rawValue:String
    var value:QyShapeFunction = .none
    var type:QySVGValueType = .absolute
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QyShapeFunction.none.validPattern) { self.value = .none }
        else if self.rawValue.isMatch(withPattern: QyShapeFunction.inset.validPattern) { self.value = .inset }
        else if self.rawValue.isMatch(withPattern: QyShapeFunction.circle.validPattern) { self.value = .circle }
        else if self.rawValue.isMatch(withPattern: QyShapeFunction.ellipse.validPattern) { self.value = .ellipse }
        else if self.rawValue.isMatch(withPattern: QyShapeFunction.polygon.validPattern) { self.value = .polygon }
        else if self.rawValue.isMatch(withPattern: QyShapeFunction.path.validPattern) { self.value = .path }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGBasicShape, rhs: QySVGBasicShape) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGBasicShape, rhs: QySVGBasicShape) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGBasicShape {
        return QySVGBasicShape(rawValue: rawValue, priority: priority)
    }
}

struct QySVGUrlValue : QySVGValue , QySVGClipPathProperties, QySVGPaintProperties, QySVGAttributeValue  {
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value = ""
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.url.rawValue) {
            if let url = self.rawValue.findFirst(withPattern: QySVGPattern.urlValue.rawValue).map({$0.value}) {
                self.value = url
            }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGUrlValue, rhs: QySVGUrlValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGUrlValue, rhs: QySVGUrlValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGUrlValue {
        return QySVGUrlValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGSpreadMethodValue : QySVGValue {
    struct SpreadMethod {
        var rawValue:String
        static let pad:SpreadMethod = .init(rawValue: "pad")
        static let reflect:SpreadMethod = .init(rawValue: "reflect")
        static let repeatV:SpreadMethod = .init(rawValue: "repeat")
    }
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:SpreadMethod = .pad
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.spreadMethod.rawValue) {
            self.value = .init(rawValue: self.rawValue)
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGSpreadMethodValue, rhs: QySVGSpreadMethodValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGSpreadMethodValue, rhs: QySVGSpreadMethodValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGSpreadMethodValue {
        return QySVGSpreadMethodValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGViewBoxValue : QySVGValue {
    struct ViewBox {
        var left, top , right, bottom:NSNumber
        static let zero:ViewBox = .init(left: 0, top: 0, right: 0, bottom: 0)
    }
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:ViewBox = .zero
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.viewBox.rawValue) {
            let data = self.rawValue.split(separator: " ").map{$0.value.number}
            if data.count >= 4 {
                self.value = .init(left: data[0], top: data[1], right: data[2], bottom: data[3])
            }
            else { self.isValid = false }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGViewBoxValue, rhs: QySVGViewBoxValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGViewBoxValue, rhs: QySVGViewBoxValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGViewBoxValue {
        return QySVGViewBoxValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGTextAnchorValue : QySVGValue {
    struct TextAnchor {
        var rawValue:String
        static let start:TextAnchor = .init(rawValue: "start")
        static let middle:TextAnchor = .init(rawValue: "middle")
        static let end:TextAnchor = .init(rawValue: "end")
    }
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:TextAnchor = .start
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.spreadMethod.rawValue) {
            self.value = .init(rawValue: self.rawValue)
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGTextAnchorValue, rhs: QySVGTextAnchorValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGTextAnchorValue, rhs: QySVGTextAnchorValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGTextAnchorValue {
        return QySVGTextAnchorValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGStringValue : QySVGValue {
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value = ""
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        self.value = rawValue
    }
    static func < (lhs: QySVGStringValue, rhs: QySVGStringValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGStringValue, rhs: QySVGStringValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGStringValue {
        return QySVGStringValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGFontStyleValue : QySVGValue{
    struct FontStyle {
        var rawValue = "normal"
        static let normal:FontStyle = .init(rawValue: "normal")
        static let italic:FontStyle = .init(rawValue: "italic")
        static let oblique:FontStyle = .init(rawValue: "oblique")
    }
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:FontStyle = .normal
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        self.value = .init(rawValue: rawValue)
    }
    static func < (lhs: QySVGFontStyleValue, rhs: QySVGFontStyleValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGFontStyleValue, rhs: QySVGFontStyleValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGFontStyleValue {
        return QySVGFontStyleValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGFontWeightValue : QySVGValue {
    struct FontWeight {
        var rawValue = "normal"
        static let normal:FontWeight = .init(rawValue: "normal")
        static let bold:FontWeight = .init(rawValue: "bold")
        static let bolder:FontWeight = .init(rawValue: "bolder")
        static let lighter:FontWeight = .init(rawValue: "lighter")
    }
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:FontWeight = .normal
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.fontWeight.rawValue){
            self.value = .init(rawValue: rawValue)
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGFontWeightValue, rhs: QySVGFontWeightValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGFontWeightValue, rhs: QySVGFontWeightValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGFontWeightValue {
        return QySVGFontWeightValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGLengthValue : QySVGValue  {
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:NSNumber = NSNumber(value: 0)
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.length.rawValue) {
            if let u = self.rawValue.findFirst(withPattern: QySVGPattern.unit.rawValue)?.value {
                self.unit = QyLengthUnit.init(rawValue: u) ?? QyLengthUnit.kUnknown
                if unit == .kPercentage { self.type = .relative }
            }
            else {
                self.unit = .kNumber
            }
            
            if let n = self.rawValue.findFirst(withPattern: QySVGPattern.number.rawValue)?.value {
                self.value = n.number
            }
        }
        else {
            self.isValid = false
        }
    }
    static func < (lhs: QySVGLengthValue, rhs: QySVGLengthValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGLengthValue, rhs: QySVGLengthValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static let zero:QySVGLengthValue = .init(rawValue: "0", priority: .initial)
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGLengthValue {
        return QySVGLengthValue(rawValue: rawValue, priority: priority)
    }
}


struct QySVGLengthListValue : QySVGValue  {
    var rawValue: String
    var type:QySVGValueType = .absolute
    var value:[NSNumber] = []
    var unit:QyLengthUnit = .kNumber
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        self.value = self.rawValue.find(withPattern: QySVGPattern.length.rawValue).map{QySVGLengthValue(rawValue: $0.value, priority: self.priority).value}
        if let u = self.rawValue.findFirst(withPattern: QySVGPattern.unit.rawValue)?.value {
            self.unit = QyLengthUnit.init(rawValue: u) ?? QyLengthUnit.kUnknown
            if unit == .kPercentage { self.type = .relative }
        }
        else {
            self.unit = .kNumber
        }
    }
    static func < (lhs: QySVGLengthListValue, rhs: QySVGLengthListValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGLengthListValue, rhs: QySVGLengthListValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGLengthListValue {
        return QySVGLengthListValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGColorValue : QySVGValue, QySVGPaintProperties {
    var value:NSColor = .clear
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.none.rawValue) {
            self.value = .clear
        }
        else if self.rawValue.isMatch(withPattern: QySVGPattern.hex3Color.rawValue) {
            self.rawValue = self.rawValue.map{String([$0,$0])}.joined()
            if let value = NSColor(hexString: self.rawValue) { self.value = value }
            else { self.isValid = false }
        }
        else if self.rawValue.isMatch(withPattern: QySVGPattern.hex6Color.rawValue) {
            if let value = NSColor(hexString: self.rawValue) { self.value = value }
            else { self.isValid = false }
        }
        else if self.rawValue.isMatch(withPattern: QySVGPattern.rgbColor.rawValue) {
            let colors = self.rawValue.find(withPattern: QySVGPattern.number.rawValue).map{$0.value.number}
            if colors.count == 3 {
                self.value = NSColor(red: colors[0].intValue, green: colors[1].intValue, blue: colors[2].intValue, alpha: 1.0)
            }
            else { self.isValid = false }
        }
        else {
            if let value = NSColor(named: self.rawValue) { self.value = value }
            else { self.isValid = false }
        }
    }
    static func < (lhs: QySVGColorValue, rhs: QySVGColorValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGColorValue, rhs: QySVGColorValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGColorValue {
        return QySVGColorValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGMatrixValue : QySVGValue, QySVGTransformProperties  {
    struct Matrix {
        var a,b,c,d,e,f :NSNumber
        static let zero = Matrix(a: 0, b: 0, c: 0, d: 0, e: 0, f: 0)
    }
    var value:Matrix = .zero
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.matrix.rawValue) {
            let number = self.rawValue.find(withPattern: QySVGPattern.number.rawValue).map{$0.value.number}
            if number.count == 6 {
                self.value = .init(a: number[0], b: number[1], c: number[2], d: number[3], e: number[4], f: number[5])
            }
            else { self.isValid = false }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGMatrixValue, rhs: QySVGMatrixValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGMatrixValue, rhs: QySVGMatrixValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGMatrixValue {
        return QySVGMatrixValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGTranslateValue : QySVGValue, QySVGTransformProperties  {
    var value:CGPoint = .zero
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.translate.rawValue) {
            let number = self.rawValue.find(withPattern: QySVGPattern.number.rawValue).map{$0.value.number}
            if number.count == 1 {
                self.value.x = CGFloat(number[0].doubleValue)
            }
            else if number.count > 1 {
                self.value.x = CGFloat(number[0].doubleValue)
                self.value.y = CGFloat(number[1].doubleValue)
            }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGTranslateValue, rhs: QySVGTranslateValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGTranslateValue, rhs: QySVGTranslateValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGTranslateValue {
        return QySVGTranslateValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGScaleValue : QySVGValue, QySVGTransformProperties  {
    var value:CGPoint = .zero
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.scale.rawValue) {
            let number = self.rawValue.find(withPattern: QySVGPattern.number.rawValue).map{$0.value.number}
            if number.count == 1 {
                self.value.x = CGFloat(number[0].doubleValue)
                self.value.y = self.value.x
            }
            else if number.count > 1 {
                self.value.x = CGFloat(number[0].doubleValue)
                self.value.y = CGFloat(number[1].doubleValue)
            }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGScaleValue, rhs: QySVGScaleValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGScaleValue, rhs: QySVGScaleValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGScaleValue {
        return QySVGScaleValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGRotateValue : QySVGValue, QySVGTransformProperties  {
    struct Rotate {
        var alngle:NSNumber
        var point:CGPoint = .zero
        static var zero:Rotate = Rotate(alngle: 0)
    }
    var value:Rotate = .zero
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.rotate.rawValue) {
            let number = self.rawValue.find(withPattern: QySVGPattern.number.rawValue).map{$0.value.number}
            if number.count == 1 {
                self.value.alngle = number[0]
            }
            else if number.count == 2 {
                self.value.alngle = number[0]
                self.value.point.x = CGFloat(number[1].doubleValue)
            }
            else if number.count == 3 {
                self.value.alngle = number[0]
                self.value.point.y = CGFloat(number[2].doubleValue)
            }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGRotateValue, rhs: QySVGRotateValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGRotateValue, rhs: QySVGRotateValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGRotateValue {
        return QySVGRotateValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGSkewXValue : QySVGValue, QySVGTransformProperties {
    var value:NSNumber = 0
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.skewX.rawValue) {
            if let number = self.rawValue.findFirst(withPattern: QySVGPattern.skewX.rawValue).map({$0.value.number}) {
                self.value = number
            }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGSkewXValue, rhs: QySVGSkewXValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGSkewXValue, rhs: QySVGSkewXValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGSkewXValue {
        return QySVGSkewXValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGSkewYValue : QySVGValue, QySVGTransformProperties  {
    var value:NSNumber = 0
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.skewY.rawValue) {
            if let number = self.rawValue.findFirst(withPattern: QySVGPattern.skewX.rawValue).map({$0.value.number}) {
                self.value = number
            }
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGSkewYValue, rhs: QySVGSkewYValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGSkewYValue, rhs: QySVGSkewYValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGSkewYValue {
        return QySVGSkewYValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGClassValue : QySVGValue   {
    var value:[String] = []
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        value = rawValue.split(separator: " ").map{String($0)}
    }
    static func < (lhs: QySVGClassValue, rhs: QySVGClassValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGClassValue, rhs: QySVGClassValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGClassValue {
        return QySVGClassValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGFillRuleValue : QySVGValue {
    var rawValue:String
    var value:CAShapeLayerFillRule = .nonZero
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.fillRule.rawValue) {
            self.value = .init(rawValue: self.rawValue)
        }
        else { self.isValid = false }
    }
    static let nonZero:QySVGFillRuleValue = .init(rawValue: CAShapeLayerFillRule.nonZero.rawValue, priority: .initial)
    static func < (lhs: QySVGFillRuleValue, rhs: QySVGFillRuleValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGFillRuleValue, rhs: QySVGFillRuleValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGFillRuleValue {
        return QySVGFillRuleValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGLineCapValue : QySVGValue {
    var rawValue:String
    var value:CAShapeLayerLineCap = .butt
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.lineCap.rawValue) {
            self.value = .init(rawValue: self.rawValue)
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGLineCapValue, rhs: QySVGLineCapValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGLineCapValue, rhs: QySVGLineCapValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGLineCapValue {
        return QySVGLineCapValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGLineJoinValue : QySVGValue {
    var rawValue:String
    var value:CAShapeLayerLineJoin = .bevel
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue.isMatch(withPattern: QySVGPattern.lineJoin.rawValue){
            self.value = .init(rawValue: rawValue)
        }
        else { self.isValid = false }
    }
    static func < (lhs: QySVGLineJoinValue, rhs: QySVGLineJoinValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGLineJoinValue, rhs: QySVGLineJoinValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGLineJoinValue {
        return QySVGLineJoinValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGVisibilityValue : QySVGValue {
    var rawValue:String
    var value:Bool = true
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        if self.rawValue != "visible" {
            value = false
        }
    }
    static func < (lhs: QySVGVisibilityValue, rhs: QySVGVisibilityValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGVisibilityValue, rhs: QySVGVisibilityValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGVisibilityValue {
        return QySVGVisibilityValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGPathValue : QySVGValue {
    var value:[SVGCommand]
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        self.value = SVGPath(rawValue).commands
    }
    // TODO: Export to another
    func toJson() -> String { return "" }
    static func < (lhs: QySVGPathValue, rhs: QySVGPathValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGPathValue, rhs: QySVGPathValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGPathValue {
        return QySVGPathValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGClipPathValue : QySVGValue {
    var value: [QySVGClipPathProperties]
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        let data:[QySVGClipPathProperties?] = self.rawValue.split(separator: " ").map({ (rawData) -> QySVGClipPathProperties? in
            if rawData.value == "none" {
                return nil
            }
            else if rawData.value.isMatch(withPattern: QyShapeFunction.url.validPattern) {
                return QySVGUrlValue(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QyShapeFunction.inset.validPattern) {
                return QySVGInsetShapeFunction(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QyShapeFunction.circle.validPattern) {
                return QySVGCircleShapeFunction(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QyShapeFunction.ellipse.validPattern) {
                return QySVGEllipseShapeFunction(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QyShapeFunction.polygon.validPattern) {
                return QySVGPolygonShapeFunction(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QyShapeFunction.path.validPattern) {
                return QySVGPathShapeFunction(rawValue: rawData.value, priority: priority)
            }
            return nil
        })
        self.value = data.compactMap{$0}
    }
    static func < (lhs: QySVGClipPathValue, rhs: QySVGClipPathValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGClipPathValue, rhs: QySVGClipPathValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGClipPathValue {
        return QySVGClipPathValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGPaintValue : QySVGValue {
    var value: [QySVGPaintProperties]
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        let data:[QySVGPaintProperties?] = self.rawValue.split(separator: " ").map { (rawData) -> QySVGPaintProperties? in
            if rawData.value.isMatch(withPattern: QySVGPattern.url.rawValue) {
                return QySVGUrlValue(rawValue: rawData.value, priority: priority)
            }
            else {
                return QySVGColorValue(rawValue: rawData.value, priority: priority)
            }
        }
        self.value = data.compactMap{$0}
    }
    static func < (lhs: QySVGPaintValue, rhs: QySVGPaintValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGPaintValue, rhs: QySVGPaintValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGPaintValue {
        return QySVGPaintValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGTransformValue : QySVGValue {
    var value: [QySVGTransformProperties]
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        let data:[QySVGTransformProperties?] = self.rawValue.split(separator: " ").map { (rawData) -> QySVGTransformProperties? in
            if rawData.value.isMatch(withPattern: QySVGPattern.translate.rawValue) {
                return QySVGTranslateValue(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QySVGPattern.matrix.rawValue) {
                return QySVGMatrixValue(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QySVGPattern.scale.rawValue) {
                return QySVGScaleValue(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QySVGPattern.rotate.rawValue) {
                return QySVGRotateValue(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QySVGPattern.skewX.rawValue) {
                return QySVGSkewXValue(rawValue: rawData.value, priority: priority)
            }
            else if rawData.value.isMatch(withPattern: QySVGPattern.skewY.rawValue) {
                return QySVGSkewYValue(rawValue: rawData.value, priority: priority)
            }
            return nil
        }
        self.value = data.compactMap{$0}
    }
    static func < (lhs: QySVGTransformValue, rhs: QySVGTransformValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGTransformValue, rhs: QySVGTransformValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGTransformValue {
        return QySVGTransformValue(rawValue: rawValue, priority: priority)
    }
}

struct QySVGStyleValue : QySVGValue {
    var value: [QySVGPresentationAttributes]
    var rawValue:String
    var type:QySVGValueType = .absolute
    var unit: QyLengthUnit = .kUnknown
    var isValid:Bool = true
    var priority: QySVGValuePriority
    init(rawValue: String, priority: QySVGValuePriority) {
        self.priority = priority
        self.rawValue = rawValue
        let data:[QySVGPresentationAttributes?] = self.rawValue.split(separator: ";").map { (rawData) -> QySVGPresentationAttributes? in
            return nil
        }
        self.value = data.compactMap{$0}
    }
    static func < (lhs: QySVGStyleValue, rhs: QySVGStyleValue) -> Bool {
        return lhs.priority.rawValue < rhs.priority.rawValue
    }
    
    static func == (lhs: QySVGStyleValue, rhs: QySVGStyleValue) -> Bool {
        return lhs.rawValue == rhs.rawValue && lhs.priority == rhs.priority
    }
    
    static func make(rawValue: String, priority: QySVGValuePriority) -> QySVGStyleValue {
        return QySVGStyleValue(rawValue: rawValue, priority: priority)
    }
}
