//
//  QySVGMaskElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGMaskElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kMask}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kHeight.rawValue] = QySVGAttribute(attributeName: .kHeight)
        self.attribute[QySVGAttributeName.kMaskContentUnits.rawValue] = QySVGAttribute(attributeName: .kMaskContentUnits)
        self.attribute[QySVGAttributeName.kMaskUnits.rawValue] = QySVGAttribute(attributeName: .kMaskUnits)
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
        self.attribute[QySVGAttributeName.kWidth.rawValue] = QySVGAttribute(attributeName: .kWidth)
        self.attribute[QySVGAttributeName.kHeight.rawValue] = QySVGAttribute(attributeName: .kHeight)
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
        self.attribute[QySVGAttributeName.kWidth.rawValue] = QySVGAttribute(attributeName: .kWidth)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kHeight.rawValue], let attribute = self.attribute[QySVGAttributeName.kHeight.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kMaskContentUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kMaskContentUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kMaskUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kMaskUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kWidth.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kHeight.rawValue], let attribute = self.attribute[QySVGAttributeName.kHeight.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kWidth.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
