//
//  QySVGTextElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGTextElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kText}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
        self.attribute[QySVGAttributeName.kDx.rawValue] = QySVGAttribute(attributeName: .kDx)
        self.attribute[QySVGAttributeName.kDy.rawValue] = QySVGAttribute(attributeName: .kDy)
        self.attribute[QySVGAttributeName.kRotate.rawValue] = QySVGAttribute(attributeName: .kRotate)
        self.attribute[QySVGAttributeName.kLengthAdjust.rawValue] = QySVGAttribute(attributeName: .kLengthAdjust)
        self.attribute[QySVGAttributeName.kTextLength.rawValue] = QySVGAttribute(attributeName: .kTextLength)
    }
    override func isAcceptableChildNode(withTag tag: QySVGTag) -> Bool {
        return tag == QySVGTag.kTextPath || tag == QySVGTag.kTspan
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kDx.rawValue], let attribute = self.attribute[QySVGAttributeName.kDx.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kDy.rawValue], let attribute = self.attribute[QySVGAttributeName.kDy.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kRotate.rawValue], let attribute = self.attribute[QySVGAttributeName.kRotate.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kLengthAdjust.rawValue], let attribute = self.attribute[QySVGAttributeName.kLengthAdjust.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kTextLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kTextLength.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
}
