//
//  QySVGAttribute.swift
//  SVG2Code
//
//  Created by Le Quang on 6/11/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGAttribute {
    var name:QySVGAttributeName
    var values:[QySVGAttributeValue] = []
    var value:QySVGAttributeValue?
    var info:String = ""
    init(name:String) {
        self.name = QySVGAttributeName(rawValue: name)
    }
    
    init(attributeName name:QySVGAttributeName){
        self.name = name
    }
    
    func setAttributeValue(value rawValue:String, priority:QySVGValuePriority = .initial) {
        if let value = paserValue(rawValue: rawValue, priority: priority) {
            self.value = value
        }
    }
    
    func addAttributeValue(value rawValue:String, priority:QySVGValuePriority = .initial) {
        if let value = paserValue(rawValue: rawValue, priority: priority) {
            values.append(value)
            sortValue()
        }
    }
    
    func addAttributes(list:[QySVGAttributeValue]){
        values.insert(contentsOf: list, at: 0)
        sortValue()
    }
    
    func sortValue() {
        switch self.name {
        case .kClipPath:
            if let list = self.values as? [QySVGClipPathValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kClipRule:
            if let list = self.values as? [QySVGFillRuleValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kColor:
            if let list = self.values as? [QySVGColorValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kCx, .kCy : // <circle>, <ellipse>, <radialGradient>: center x position
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kD:
            if let list = self.values as? [QySVGPathValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFill:
            if let list = self.values as? [QySVGPaintValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFillRule:
            if let list = self.values as? [QySVGFillRuleValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFontFamily:
            if let list = self.values as? [QySVGStringValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFontSize:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFontStyle:
            if let list = self.values as? [QySVGFontStyleValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFontWeight:
            if let list = self.values as? [QySVGFontWeightValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFx: // <radialGradient>: focal point x position
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFy: // <radialGradient>: focal point y position
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kGradientTransform:
            if let list = self.values as? [QySVGTransformValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kHeight:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kHref:
            if let list = self.values as? [QySVGStringValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kFillOpacity, .kOpacity, .kStrokeOpacity:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kPatternTransform:
            if let list = self.values as? [QySVGTransformValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kPoints:
            if let list = self.values as? [QySVGLengthListValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kR, .kRy, .kRy:  // <circle>, <radialGradient>: radius, <ellipse>,<rect>: horizontal (corner) radius, <ellipse>,<rect>: vertical (corner) radius
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kSpreadMethod:
            if let list = self.values as? [QySVGSpreadMethodValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStopColor:
            if let list = self.values as? [QySVGColorValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kContentStyleType:
            if let list = self.values as? [QySVGStringValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStroke:
            if let list = self.values as? [QySVGPaintValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeDasharray:
            if let list = self.values as? [QySVGLengthListValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeDashoffset:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeOpacity:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeLinecap:
            if let list = self.values as? [QySVGLineCapValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeLinejoin:
            if let list = self.values as? [QySVGLineJoinValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeMiterlimit:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kStrokeWidth:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kTransform:
            if let list = self.values as? [QySVGTransformValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kTextAnchor:
            if let list = self.values as? [QySVGTextAnchorValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kViewBox:
            if let list = self.values as? [QySVGViewBoxValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kVisibility:
            if let list = self.values as? [QySVGVisibilityValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kWidth:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kX:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kX1: // <line>: first endpoint x
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kX2: // <line>: second endpoint x
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kY:
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kY1: // <line>: first endpoint y
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        case .kY2: // <line>: second endpoint y
            if let list = self.values as? [QySVGLengthValue] {
                self.values = list.sorted{$0 > $1}
            }
            break
        default:
            info = "Attribute with name \(name.rawValue) not suported"
            print(info)
        }
    }
    
    private func paserValue(rawValue:String, priority:QySVGValuePriority) -> QySVGAttributeValue? {
        for (_, data) in qySVGStoreAttributeEntry.enumerated() {
            if data.key == name.rawValue { return data.value(rawValue, priority) }
        }
        return nil
    }
}

extension Dictionary where Key == String, Value == QySVGAttribute  {
    mutating func computedStyleValue(withSheet stylesheet:QySVGStyleSheet, selector:QySVGCSSElement, deep:Int = 0){
        let properties = stylesheet.styleSheet.stylesForElement(selector)
        for item in QySVGAttributeNameCategory.presentationAttributes {
            if let value = properties[item.rawValue]?.value {
                if let attribute = self[item.rawValue], attribute.value?.priority == QySVGValuePriority.initial {
                    attribute.setAttributeValue(value: value, priority: .cssstyle)
                }
                else {
                    let attribute = QySVGAttribute(attributeName: .kAlignmentBaseline)
                    attribute.setAttributeValue(value: value, priority: .cssstyle)
                    self[QySVGAttributeName.kAlignmentBaseline.rawValue] = QySVGAttribute(attributeName: .kAlignmentBaseline)
                }
            }
        }
    }
    
    mutating func merge(withParentAttibutes attributtes:[String:QySVGAttribute]) {
        for item in QySVGAttributeNameCategory.presentationAttributes {
            if let value = attributtes[item.rawValue] {
                value.value?.priority = .inherit
                if let attribute = self[item.rawValue], attribute.value?.priority == QySVGValuePriority.initial {
                    attribute.value = value.value
                }
                else {
                    self[item.rawValue] = value
                }
            }
        }
    }
}

