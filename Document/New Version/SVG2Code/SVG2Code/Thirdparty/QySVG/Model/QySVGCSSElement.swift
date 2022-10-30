//
//  QySVGCSSElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/17/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGStyleSheet {
    private(set) var styleSheet:StyleSheet
    private var styleSize:Int = MemoryLayout<Rule>.stride
    private(set) var memoryQySVGStyleSheet:Int = 0
    init(withCssString string:String) {
        self.styleSheet = StyleSheet(string: string) ?? StyleSheet()
    }
    func add(CssString string:String){
        if let sheet = StyleSheet(string: string) {
            self.styleSheet.rules.append(contentsOf: sheet.rules)
            self.memoryQySVGStyleSheet = styleSize*self.styleSheet.rules.count
        }
    }
    
}

class QySVGCSSElement: StyleElement, Equatable {
    var id: String?
    var classNames: [String]?
    var tagName: String?
    var parentElement: StyleElement?
    var childElements: [StyleElement]?
    var attributes: [String: String]?
    var styles: [String: Any]?
    var properties:[String: StyleDeclaration]?
    
    var isFocused: Bool
    var isEnabled: Bool
    var isSelected: Bool
    var isActive: Bool
    
    init(id: String? = nil,
         classNames: [String]? = nil,
         tagName: String? = nil,
         parent: StyleElement? = nil,
         children: [StyleElement]? = nil,
         attributes: [String: String]? = nil) {
          self.id = id
          self.classNames = classNames
          self.tagName = tagName
          self.parentElement = parent
          self.childElements = children
          self.attributes = attributes
          isEnabled = true
          isFocused = false
          isSelected = false
          isActive = false
    }
    
    init(tagName:String, stylesheet:StyleSheet) {
        self.tagName = tagName
        isEnabled = true
        isFocused = false
        isSelected = false
        isActive = false
        self.properties = stylesheet.stylesForElement(self)
    }
    
    init(classNames:[String], stylesheet:StyleSheet) {
        self.classNames = classNames
        isEnabled = true
        isFocused = false
        isSelected = false
        isActive = false
        self.properties = stylesheet.stylesForElement(self)
    }
    
    func apply(withstylesheet stylesheet:StyleSheet){
        self.properties = stylesheet.stylesForElement(self)
    }
    
    func has(attribute: String, with value: String) -> Bool {
        return attributes?[attribute] == value
    }
    
    func equals(_ other: StyleElement) -> Bool {
        return self == (other as! QySVGCSSElement)
    }
    
    func apply(styles: [String : Any]) {
        self.styles = styles
    }
    
    static func == (lhs: QySVGCSSElement, rhs: QySVGCSSElement) -> Bool {
        return lhs as AnyObject === rhs
    }
}

extension QySVGCSSElement {
    func update(withNode node:QySVGNode) {
        if let element = node.element {
            self.tagName = element.name
            if let id = element.attributes["id"] { self.id = id }
            if let classes = element.attributes["class"]?.split(separator: " ").map({$0.value}) { self.classNames = classes}
            //MARK: Get key/value CSS in content of style
            if let style = element.attributes["style"] {
                self.attributes = style.split(byPair: ":", group: ";")
            }
            //MARK: Update CSS prefer, find parent selector
            if let parent = node.parentNode {
                self.parentElement = parent.selector
                parent.selector?.childElements?.append(self)
            }
            
        }
    }
    static func make(withNode node:QySVGNode) -> QySVGCSSElement {
        let selector = QySVGCSSElement()
        selector.update(withNode: node)
        return selector
    }
    
    func computedStyleValue(withSheet stylesheet:QySVGStyleSheet, deep:Int = 0) -> [String:QySVGAttribute] {
        var values:[String:QySVGAttribute] = [:]
        let priority = QySVGValuePriority(rawValue: QySVGValuePriority.cssstyle.rawValue + deep)
        let properties = stylesheet.styleSheet.stylesForElement(self)
        if let value = properties[QySVGAttributeName.kAlignmentBaseline.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kAlignmentBaseline)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kAlignmentBaseline.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kBaselineShift.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kBaselineShift)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kBaselineShift.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kClip.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kClip)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kClip.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kClipPath.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kClipPath)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kClipPath.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kClipRule.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kClipRule)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kClipRule.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kColor.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kColor)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kColor.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kColorInterpolation.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kColorInterpolation)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kColorInterpolation.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kColorInterpolationFilters.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kColorInterpolationFilters)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kColorInterpolationFilters.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kColorProfile.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kColorProfile)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kColorProfile.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kColorRendering.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kColorRendering)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kColorRendering.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kCursor.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kCursor)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kCursor.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kDirection.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kDirection)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kDirection.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kDisplay.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kDisplay)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kDisplay.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kDominantBaseline.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kDominantBaseline)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kDominantBaseline.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kEnableBackground.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kEnableBackground)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kEnableBackground.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFill.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFill)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFill.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFillOpacity.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFillOpacity)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFillOpacity.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFillRule.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFillRule)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFillRule.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFilter.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFilter)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFilter.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFloodColor.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFloodColor)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFloodColor.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFloodOpacity.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFloodOpacity)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFloodOpacity.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontFamily.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontFamily)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontFamily.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontSize.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontSize)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontSize.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontSizeAdjust.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontSizeAdjust)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontSizeAdjust.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontStretch.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontStretch)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontStretch.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontStyle.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontStyle)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontStyle.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontVariant.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontVariant)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontVariant.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kFontWeight.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kFontWeight)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kFontWeight.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kGlyphOrientationHorizontal)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kGlyphOrientationHorizontal.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kGlyphOrientationVertical.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kGlyphOrientationVertical)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kGlyphOrientationVertical.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kImageRendering.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kImageRendering)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kImageRendering.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kKerning.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kKerning)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kKerning.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kLetterSpacing.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kLetterSpacing)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kLetterSpacing.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kLightingColor.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kLightingColor)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kLightingColor.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kMarkerEnd.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kMarkerEnd)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kMarkerEnd.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kMarkerMid.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kMarkerMid)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kMarkerMid.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kMarkerStart.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kMarkerStart)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kMarkerStart.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kMask.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kMask)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kMask.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kOpacity.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kOpacity)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kOpacity.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kOverflow.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kOverflow)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kOverflow.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kPointerEvents.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kPointerEvents)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kPointerEvents.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kShapeRendering.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kShapeRendering)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kShapeRendering.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStopColor.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStopColor)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStopColor.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStopOpacity.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStopOpacity)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStopOpacity.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStroke.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStroke)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStroke.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeDasharray.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeDasharray)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeDasharray.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeDashoffset.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeDashoffset)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeDashoffset.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeLinecap.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeLinecap)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeLinecap.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeLinejoin.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeLinejoin)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeLinejoin.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeMiterlimit.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeMiterlimit)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeMiterlimit.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeOpacity.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeOpacity)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeOpacity.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kStrokeWidth.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kStrokeWidth)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kStrokeWidth.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kTextAnchor.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kTextAnchor)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kTextAnchor.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kTextDecoration.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kTextDecoration)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kTextDecoration.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kTextRendering.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kTextRendering)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kTextRendering.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kTransform.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kTransform)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kTransform.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kTransformOrigin.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kTransformOrigin)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kTransformOrigin.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kUnicodeBidi.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kUnicodeBidi)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kUnicodeBidi.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kVectorEffect.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kVectorEffect)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kVectorEffect.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kVisibility.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kVisibility)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kVisibility.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kWordSpacing.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kWordSpacing)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kWordSpacing.rawValue] = attribute
        }
        if let value = properties[QySVGAttributeName.kWritingMode.rawValue]?.value {
            let attribute = QySVGAttribute(attributeName: .kWritingMode)
            attribute.addAttributeValue(value: value, priority: priority)
            values[QySVGAttributeName.kWritingMode.rawValue] = attribute
        }
        return values
    }
}
