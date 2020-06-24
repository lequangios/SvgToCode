//
//  QySVGTextPathElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGTextPathElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kTextPath}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kHref.rawValue] = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kLengthAdjust.rawValue] = QySVGAttribute(attributeName: .kLengthAdjust)
        self.attribute[QySVGAttributeName.kMethod.rawValue] = QySVGAttribute(attributeName: .kMethod)
        self.attribute[QySVGAttributeName.kPath.rawValue] = QySVGAttribute(attributeName: .kPath)
        self.attribute[QySVGAttributeName.kSpacing.rawValue] = QySVGAttribute(attributeName: .kSpacing)
        self.attribute[QySVGAttributeName.kStartOffset.rawValue] = QySVGAttribute(attributeName: .kStartOffset)
        self.attribute[QySVGAttributeName.kTextLength.rawValue] = QySVGAttribute(attributeName: .kTextLength)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kLengthAdjust.rawValue], let attribute = self.attribute[QySVGAttributeName.kLengthAdjust.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kMethod.rawValue], let attribute = self.attribute[QySVGAttributeName.kMethod.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPath.rawValue], let attribute = self.attribute[QySVGAttributeName.kPath.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kSpacing.rawValue], let attribute = self.attribute[QySVGAttributeName.kSpacing.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStartOffset.rawValue], let attribute = self.attribute[QySVGAttributeName.kStartOffset.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kTextLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kTextLength.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        
    }
}
