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
    var info:String = ""
    init(name:String) {
        self.name = QySVGAttributeName(rawValue: name)
    }
    
    init(attributeName name:QySVGAttributeName){
        self.name = name
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
        switch name {
        case .kClipPath:
            return QySVGClipPathValue(rawValue: rawValue, priority: priority)
        case .kClipRule:
            return QySVGFillRuleValue(rawValue: rawValue, priority: priority)
        case .kColor:
            return QySVGColorValue(rawValue: rawValue, priority: priority)
        case .kCx, .kCy : // <circle>, <ellipse>, <radialGradient>: center x position
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kD:
            return QySVGPathValue(rawValue: rawValue, priority: priority)
        case .kFill:
            return QySVGPaintValue(rawValue: rawValue, priority: priority)
        case .kFillRule:
            return QySVGFillRuleValue(rawValue: rawValue, priority: priority)
        case .kFontFamily:
            return QySVGStringValue(rawValue: rawValue, priority: priority)
        case .kFontSize:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kFontStyle:
            return QySVGFontStyleValue(rawValue: rawValue, priority: priority)
        case .kFontWeight:
            return QySVGFontWeightValue(rawValue: rawValue, priority: priority)
        case .kFx: // <radialGradient>: focal point x position
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kFy: // <radialGradient>: focal point y position
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kGradientTransform:
            return QySVGTransformValue(rawValue: rawValue, priority: priority)
        case .kHeight:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kHref:
            return QySVGStringValue(rawValue: rawValue, priority: priority)
        case .kFillOpacity, .kOpacity, .kStrokeOpacity:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kPatternTransform:
            return QySVGTransformValue(rawValue: rawValue, priority: priority)
        case .kPoints:
            return QySVGLengthListValue(rawValue: rawValue, priority: priority)
        case .kR, .kRy, .kRy:  // <circle>, <radialGradient>: radius, <ellipse>,<rect>: horizontal (corner) radius, <ellipse>,<rect>: vertical (corner) radius
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kSpreadMethod:
            return QySVGSpreadMethodValue(rawValue: rawValue, priority: priority)
        case .kStopColor:
            return QySVGColorValue(rawValue: rawValue, priority: priority)
        case .kContentStyleType:
            return QySVGStringValue(rawValue: rawValue, priority: priority)
        case .kStroke:
            return QySVGPaintValue(rawValue: rawValue, priority: priority)
        case .kStrokeDasharray:
            return QySVGLengthListValue(rawValue: rawValue, priority: priority)
        case .kStrokeDashoffset:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kStrokeOpacity:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kStrokeLinecap:
            return QySVGLineCapValue(rawValue: rawValue, priority: priority)
        case .kStrokeLinejoin:
            return QySVGLineJoinValue(rawValue: rawValue, priority: priority)
        case .kStrokeMiterlimit:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kStrokeWidth:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kTransform:
            return QySVGTransformValue(rawValue: rawValue, priority: priority)
        case .kTextAnchor:
            return QySVGTextAnchorValue(rawValue: rawValue, priority: priority)
        case .kViewBox:
            return QySVGViewBoxValue(rawValue: rawValue, priority: priority)
        case .kVisibility:
            return QySVGVisibilityValue(rawValue: rawValue, priority: priority)
        case .kWidth:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kX:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kX1: // <line>: first endpoint x
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kX2: // <line>: second endpoint x
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kY:
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kY1: // <line>: first endpoint y
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        case .kY2: // <line>: second endpoint y
            return QySVGLengthValue(rawValue: rawValue, priority: priority)
        default:
            info = "Attribute with name \(name.rawValue) not suported"
            print(info)
        }
        return nil
    }
}

extension Dictionary where Key == String, Value == QySVGAttribute  {
    mutating func computedStyleValue(withSheet stylesheet:QySVGStyleSheet, selector:QySVGCSSElement, deep:Int = 0){
        let priority = QySVGValuePriority(rawValue: QySVGValuePriority.cssstyle.rawValue + deep)
        let properties = stylesheet.styleSheet.stylesForElement(selector)
        if let value = properties[QySVGAttributeName.kAlignmentBaseline.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kAlignmentBaseline.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kAlignmentBaseline)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kAlignmentBaseline.rawValue] = QySVGAttribute(attributeName: .kAlignmentBaseline)
            }
        }
        if let value = properties[QySVGAttributeName.kBaselineShift.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kBaselineShift.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kBaselineShift)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kBaselineShift.rawValue] = QySVGAttribute(attributeName: .kBaselineShift)
            }
        }
        if let value = properties[QySVGAttributeName.kClip.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kClip.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kClip)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kClip.rawValue] = QySVGAttribute(attributeName: .kClip)
            }
        }
        if let value = properties[QySVGAttributeName.kClipPath.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kClipPath.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kClipPath)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kClipPath.rawValue] = QySVGAttribute(attributeName: .kClipPath)
            }
        }
        if let value = properties[QySVGAttributeName.kClipRule.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kClipRule.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kClipRule)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kClipRule.rawValue] = QySVGAttribute(attributeName: .kClipRule)
            }
        }
        if let value = properties[QySVGAttributeName.kColor.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kColor.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kColor)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kColor.rawValue] = QySVGAttribute(attributeName: .kColor)
            }
        }
        if let value = properties[QySVGAttributeName.kColorInterpolation.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kColorInterpolation.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kColorInterpolation)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kColorInterpolation.rawValue] = QySVGAttribute(attributeName: .kColorInterpolation)
            }
        }
        if let value = properties[QySVGAttributeName.kColorInterpolationFilters.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kColorInterpolationFilters.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kColorInterpolationFilters)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kColorInterpolationFilters.rawValue] = QySVGAttribute(attributeName: .kColorInterpolationFilters)
            }
        }
        if let value = properties[QySVGAttributeName.kColorProfile.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kColorProfile.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kColorProfile)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kColorProfile.rawValue] = QySVGAttribute(attributeName: .kColorProfile)
            }
        }
        if let value = properties[QySVGAttributeName.kColorRendering.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kColorRendering.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kColorRendering)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kColorRendering.rawValue] = QySVGAttribute(attributeName: .kColorRendering)
            }
        }
        if let value = properties[QySVGAttributeName.kCursor.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kCursor.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kCursor)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kCursor.rawValue] = QySVGAttribute(attributeName: .kCursor)
            }
        }
        if let value = properties[QySVGAttributeName.kDirection.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kDirection.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kDirection)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kDirection.rawValue] = QySVGAttribute(attributeName: .kDirection)
            }
        }
        if let value = properties[QySVGAttributeName.kDisplay.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kDisplay.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kDisplay)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kDisplay.rawValue] = QySVGAttribute(attributeName: .kDisplay)
            }
        }
        if let value = properties[QySVGAttributeName.kDominantBaseline.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kDominantBaseline.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kDominantBaseline)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kDominantBaseline.rawValue] = QySVGAttribute(attributeName: .kDominantBaseline)
            }
        }
        if let value = properties[QySVGAttributeName.kEnableBackground.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kEnableBackground.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kEnableBackground)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kEnableBackground.rawValue] = QySVGAttribute(attributeName: .kEnableBackground)
            }
        }
        if let value = properties[QySVGAttributeName.kFill.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFill.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFill)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFill.rawValue] = QySVGAttribute(attributeName: .kFill)
            }
        }
        if let value = properties[QySVGAttributeName.kFillOpacity.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFillOpacity.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFillOpacity)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFillOpacity.rawValue] = QySVGAttribute(attributeName: .kFillOpacity)
            }
        }
        if let value = properties[QySVGAttributeName.kFillRule.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFillRule.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFillRule)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFillRule.rawValue] = QySVGAttribute(attributeName: .kFillRule)
            }
        }
        if let value = properties[QySVGAttributeName.kFilter.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFilter.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFilter)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFilter.rawValue] = QySVGAttribute(attributeName: .kFilter)
            }
        }
        if let value = properties[QySVGAttributeName.kFloodColor.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFloodColor.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFloodColor)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFloodColor.rawValue] = QySVGAttribute(attributeName: .kFloodColor)
            }
        }
        if let value = properties[QySVGAttributeName.kFloodOpacity.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFloodOpacity.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFloodOpacity)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFloodOpacity.rawValue] = QySVGAttribute(attributeName: .kFloodOpacity)
            }
        }
        if let value = properties[QySVGAttributeName.kFontFamily.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontFamily.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontFamily)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontFamily.rawValue] = QySVGAttribute(attributeName: .kFontFamily)
            }
        }
        if let value = properties[QySVGAttributeName.kFontSize.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontSize.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontSize)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontSize.rawValue] = QySVGAttribute(attributeName: .kFontSize)
            }
        }
        if let value = properties[QySVGAttributeName.kFontSizeAdjust.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontSizeAdjust.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontSizeAdjust)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontSizeAdjust.rawValue] = QySVGAttribute(attributeName: .kFontSizeAdjust)
            }
        }
        if let value = properties[QySVGAttributeName.kFontStretch.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontStretch.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontStretch)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontStretch.rawValue] = QySVGAttribute(attributeName: .kFontStretch)
            }
        }
        if let value = properties[QySVGAttributeName.kFontStyle.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontStyle.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontStyle)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontStyle.rawValue] = QySVGAttribute(attributeName: .kFontStyle)
            }
        }
        if let value = properties[QySVGAttributeName.kFontVariant.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontVariant.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontVariant)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontVariant.rawValue] = QySVGAttribute(attributeName: .kFontVariant)
            }
        }
        if let value = properties[QySVGAttributeName.kFontWeight.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kFontWeight.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kFontWeight)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kFontWeight.rawValue] = QySVGAttribute(attributeName: .kFontWeight)
            }
        }
        if let value = properties[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kGlyphOrientationHorizontal)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue] = QySVGAttribute(attributeName: .kGlyphOrientationHorizontal)
            }
        }
        if let value = properties[QySVGAttributeName.kGlyphOrientationVertical.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kGlyphOrientationVertical.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kGlyphOrientationVertical)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kGlyphOrientationVertical.rawValue] = QySVGAttribute(attributeName: .kGlyphOrientationVertical)
            }
        }
        if let value = properties[QySVGAttributeName.kImageRendering.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kImageRendering.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kImageRendering)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kImageRendering.rawValue] = QySVGAttribute(attributeName: .kImageRendering)
            }
        }
        if let value = properties[QySVGAttributeName.kKerning.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kKerning.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kKerning)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kKerning.rawValue] = QySVGAttribute(attributeName: .kKerning)
            }
        }
        if let value = properties[QySVGAttributeName.kLetterSpacing.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kLetterSpacing.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kLetterSpacing)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kLetterSpacing.rawValue] = QySVGAttribute(attributeName: .kLetterSpacing)
            }
        }
        if let value = properties[QySVGAttributeName.kLightingColor.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kLightingColor.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kLightingColor)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kLightingColor.rawValue] = QySVGAttribute(attributeName: .kLightingColor)
            }
        }
        if let value = properties[QySVGAttributeName.kMarkerEnd.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kMarkerEnd.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kMarkerEnd)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kMarkerEnd.rawValue] = QySVGAttribute(attributeName: .kMarkerEnd)
            }
        }
        if let value = properties[QySVGAttributeName.kMarkerMid.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kMarkerMid.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kMarkerMid)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kMarkerMid.rawValue] = QySVGAttribute(attributeName: .kMarkerMid)
            }
        }
        if let value = properties[QySVGAttributeName.kMarkerStart.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kMarkerStart.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kMarkerStart)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kMarkerStart.rawValue] = QySVGAttribute(attributeName: .kMarkerStart)
            }
        }
        if let value = properties[QySVGAttributeName.kMask.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kMask.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kMask)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kMask.rawValue] = QySVGAttribute(attributeName: .kMask)
            }
        }
        if let value = properties[QySVGAttributeName.kOpacity.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kOpacity.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kOpacity)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kOpacity.rawValue] = QySVGAttribute(attributeName: .kOpacity)
            }
        }
        if let value = properties[QySVGAttributeName.kOverflow.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kOverflow.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kOverflow)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kOverflow.rawValue] = QySVGAttribute(attributeName: .kOverflow)
            }
        }
        if let value = properties[QySVGAttributeName.kPointerEvents.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kPointerEvents.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kPointerEvents)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kPointerEvents.rawValue] = QySVGAttribute(attributeName: .kPointerEvents)
            }
        }
        if let value = properties[QySVGAttributeName.kShapeRendering.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kShapeRendering.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kShapeRendering)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kShapeRendering.rawValue] = QySVGAttribute(attributeName: .kShapeRendering)
            }
        }
        if let value = properties[QySVGAttributeName.kStopColor.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStopColor.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStopColor)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStopColor.rawValue] = QySVGAttribute(attributeName: .kStopColor)
            }
        }
        if let value = properties[QySVGAttributeName.kStopOpacity.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStopOpacity.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStopOpacity)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStopOpacity.rawValue] = QySVGAttribute(attributeName: .kStopOpacity)
            }
        }
        if let value = properties[QySVGAttributeName.kStroke.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStroke.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStroke)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStroke.rawValue] = QySVGAttribute(attributeName: .kStroke)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeDasharray.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeDasharray.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeDasharray)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeDasharray.rawValue] = QySVGAttribute(attributeName: .kStrokeDasharray)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeDashoffset.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeDashoffset.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeDashoffset)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeDashoffset.rawValue] = QySVGAttribute(attributeName: .kStrokeDashoffset)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeLinecap.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeLinecap.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeLinecap)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeLinecap.rawValue] = QySVGAttribute(attributeName: .kStrokeLinecap)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeLinejoin.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeLinejoin.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeLinejoin)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeLinejoin.rawValue] = QySVGAttribute(attributeName: .kStrokeLinejoin)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeMiterlimit.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeMiterlimit.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeMiterlimit)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeMiterlimit.rawValue] = QySVGAttribute(attributeName: .kStrokeMiterlimit)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeOpacity.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeOpacity.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeOpacity)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeOpacity.rawValue] = QySVGAttribute(attributeName: .kStrokeOpacity)
            }
        }
        if let value = properties[QySVGAttributeName.kStrokeWidth.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kStrokeWidth.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kStrokeWidth)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kStrokeWidth.rawValue] = QySVGAttribute(attributeName: .kStrokeWidth)
            }
        }
        if let value = properties[QySVGAttributeName.kTextAnchor.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kTextAnchor.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kTextAnchor)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kTextAnchor.rawValue] = QySVGAttribute(attributeName: .kTextAnchor)
            }
        }
        if let value = properties[QySVGAttributeName.kTextDecoration.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kTextDecoration.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kTextDecoration)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kTextDecoration.rawValue] = QySVGAttribute(attributeName: .kTextDecoration)
            }
        }
        if let value = properties[QySVGAttributeName.kTextRendering.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kTextRendering.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kTextRendering)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kTextRendering.rawValue] = QySVGAttribute(attributeName: .kTextRendering)
            }
        }
        if let value = properties[QySVGAttributeName.kTransform.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kTransform.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kTransform)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kTransform.rawValue] = QySVGAttribute(attributeName: .kTransform)
            }
        }
        if let value = properties[QySVGAttributeName.kTransformOrigin.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kTransformOrigin.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kTransformOrigin)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kTransformOrigin.rawValue] = QySVGAttribute(attributeName: .kTransformOrigin)
            }
        }
        if let value = properties[QySVGAttributeName.kUnicodeBidi.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kUnicodeBidi.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kUnicodeBidi)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kUnicodeBidi.rawValue] = QySVGAttribute(attributeName: .kUnicodeBidi)
            }
        }
        if let value = properties[QySVGAttributeName.kVectorEffect.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kVectorEffect.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kVectorEffect)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kVectorEffect.rawValue] = QySVGAttribute(attributeName: .kVectorEffect)
            }
        }
        if let value = properties[QySVGAttributeName.kVisibility.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kVisibility.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kVisibility)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kVisibility.rawValue] = QySVGAttribute(attributeName: .kVisibility)
            }
        }
        if let value = properties[QySVGAttributeName.kWordSpacing.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kWordSpacing.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kWordSpacing)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kWordSpacing.rawValue] = QySVGAttribute(attributeName: .kWordSpacing)
            }
        }
        if let value = properties[QySVGAttributeName.kWritingMode.rawValue]?.value {
            if let attribute = self[QySVGAttributeName.kWritingMode.rawValue] {
                attribute.addAttributeValue(value: value, priority: priority)
            }
            else {
                let attribute = QySVGAttribute(attributeName: .kWritingMode)
                attribute.addAttributeValue(value: value, priority: priority)
                self[QySVGAttributeName.kWritingMode.rawValue] = QySVGAttribute(attributeName: .kWritingMode)
            }
        }
    }
    
    mutating func merge(withAttibutes attributtes:[String:QySVGAttribute]) {
        if let value = attributtes[QySVGAttributeName.kAlignmentBaseline.rawValue] {
            if let attribute = self[QySVGAttributeName.kAlignmentBaseline.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kAlignmentBaseline.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kBaselineShift.rawValue] {
            if let attribute = self[QySVGAttributeName.kBaselineShift.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kBaselineShift.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kClip.rawValue] {
            if let attribute = self[QySVGAttributeName.kClip.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kClip.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kClipPath.rawValue] {
            if let attribute = self[QySVGAttributeName.kClipPath.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kClipPath.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kClipRule.rawValue] {
            if let attribute = self[QySVGAttributeName.kClipRule.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kClipRule.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kColor.rawValue] {
            if let attribute = self[QySVGAttributeName.kColor.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kColor.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kColorInterpolation.rawValue] {
            if let attribute = self[QySVGAttributeName.kColorInterpolation.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kColorInterpolation.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kColorInterpolationFilters.rawValue] {
            if let attribute = self[QySVGAttributeName.kColorInterpolationFilters.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kColorInterpolationFilters.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kColorProfile.rawValue] {
            if let attribute = self[QySVGAttributeName.kColorProfile.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kColorProfile.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kColorRendering.rawValue] {
            if let attribute = self[QySVGAttributeName.kColorRendering.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kColorRendering.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kCursor.rawValue] {
            if let attribute = self[QySVGAttributeName.kCursor.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kCursor.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kDirection.rawValue] {
            if let attribute = self[QySVGAttributeName.kDirection.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kDirection.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kDisplay.rawValue] {
            if let attribute = self[QySVGAttributeName.kDisplay.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kDisplay.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kDominantBaseline.rawValue] {
            if let attribute = self[QySVGAttributeName.kDominantBaseline.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kDominantBaseline.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kEnableBackground.rawValue] {
            if let attribute = self[QySVGAttributeName.kEnableBackground.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kEnableBackground.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFill.rawValue] {
            if let attribute = self[QySVGAttributeName.kFill.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFill.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFillOpacity.rawValue] {
            if let attribute = self[QySVGAttributeName.kFillOpacity.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFillOpacity.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFillRule.rawValue] {
            if let attribute = self[QySVGAttributeName.kFillRule.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFillRule.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFilter.rawValue] {
            if let attribute = self[QySVGAttributeName.kFilter.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFilter.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFloodColor.rawValue] {
            if let attribute = self[QySVGAttributeName.kFloodColor.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFloodColor.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFloodOpacity.rawValue] {
            if let attribute = self[QySVGAttributeName.kFloodOpacity.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFloodOpacity.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontFamily.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontFamily.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontFamily.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontSize.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontSize.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontSize.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontSizeAdjust.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontSizeAdjust.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontSizeAdjust.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontStretch.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontStretch.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontStretch.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontStyle.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontStyle.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontStyle.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontVariant.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontVariant.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontVariant.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kFontWeight.rawValue] {
            if let attribute = self[QySVGAttributeName.kFontWeight.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kFontWeight.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue] {
            if let attribute = self[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kGlyphOrientationVertical.rawValue] {
            if let attribute = self[QySVGAttributeName.kGlyphOrientationVertical.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kGlyphOrientationVertical.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kImageRendering.rawValue] {
            if let attribute = self[QySVGAttributeName.kImageRendering.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kImageRendering.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kKerning.rawValue] {
            if let attribute = self[QySVGAttributeName.kKerning.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kKerning.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kLetterSpacing.rawValue] {
            if let attribute = self[QySVGAttributeName.kLetterSpacing.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kLetterSpacing.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kLightingColor.rawValue] {
            if let attribute = self[QySVGAttributeName.kLightingColor.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kLightingColor.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kMarkerEnd.rawValue] {
            if let attribute = self[QySVGAttributeName.kMarkerEnd.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kMarkerEnd.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kMarkerMid.rawValue] {
            if let attribute = self[QySVGAttributeName.kMarkerMid.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kMarkerMid.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kMarkerStart.rawValue] {
            if let attribute = self[QySVGAttributeName.kMarkerStart.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kMarkerStart.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kMask.rawValue] {
            if let attribute = self[QySVGAttributeName.kMask.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kMask.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kOpacity.rawValue] {
            if let attribute = self[QySVGAttributeName.kOpacity.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kOpacity.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kOverflow.rawValue] {
            if let attribute = self[QySVGAttributeName.kOverflow.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kOverflow.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kPointerEvents.rawValue] {
            if let attribute = self[QySVGAttributeName.kPointerEvents.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kPointerEvents.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kShapeRendering.rawValue] {
            if let attribute = self[QySVGAttributeName.kShapeRendering.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kShapeRendering.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStopColor.rawValue] {
            if let attribute = self[QySVGAttributeName.kStopColor.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStopColor.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStopOpacity.rawValue] {
            if let attribute = self[QySVGAttributeName.kStopOpacity.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStopOpacity.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStroke.rawValue] {
            if let attribute = self[QySVGAttributeName.kStroke.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStroke.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeDasharray.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeDasharray.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeDasharray.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeDashoffset.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeDashoffset.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeDashoffset.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeLinecap.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeLinecap.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeLinecap.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeLinejoin.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeLinejoin.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeLinejoin.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeMiterlimit.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeMiterlimit.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeMiterlimit.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeOpacity.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeOpacity.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeOpacity.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kStrokeWidth.rawValue] {
            if let attribute = self[QySVGAttributeName.kStrokeWidth.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kStrokeWidth.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kTextAnchor.rawValue] {
            if let attribute = self[QySVGAttributeName.kTextAnchor.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kTextAnchor.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kTextDecoration.rawValue] {
            if let attribute = self[QySVGAttributeName.kTextDecoration.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kTextDecoration.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kTextRendering.rawValue] {
            if let attribute = self[QySVGAttributeName.kTextRendering.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kTextRendering.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kTransform.rawValue] {
            if let attribute = self[QySVGAttributeName.kTransform.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kTransform.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kTransformOrigin.rawValue] {
            if let attribute = self[QySVGAttributeName.kTransformOrigin.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kTransformOrigin.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kUnicodeBidi.rawValue] {
            if let attribute = self[QySVGAttributeName.kUnicodeBidi.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kUnicodeBidi.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kVectorEffect.rawValue] {
            if let attribute = self[QySVGAttributeName.kVectorEffect.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kVectorEffect.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kVisibility.rawValue] {
            if let attribute = self[QySVGAttributeName.kVisibility.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kVisibility.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kWordSpacing.rawValue] {
            if let attribute = self[QySVGAttributeName.kWordSpacing.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kWordSpacing.rawValue] = value
            }
        }

        if let value = attributtes[QySVGAttributeName.kWritingMode.rawValue] {
            if let attribute = self[QySVGAttributeName.kWritingMode.rawValue] {
                attribute.addAttributes(list: value.values)
            }
            else {
                self[QySVGAttributeName.kWritingMode.rawValue] = value
            }
        }
    }
}

