//
//  QySVGRectElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGRectElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kRect}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
        self.attribute[QySVGAttributeName.kWidth.rawValue] = QySVGAttribute(attributeName: .kWidth)
        self.attribute[QySVGAttributeName.kHeight.rawValue] = QySVGAttribute(attributeName: .kHeight)
        self.attribute[QySVGAttributeName.kRx.rawValue] = QySVGAttribute(attributeName: .kRx)
        self.attribute[QySVGAttributeName.kRy.rawValue] = QySVGAttribute(attributeName: .kRy)
        self.attribute[QySVGAttributeName.kPathLength.rawValue] = QySVGAttribute(attributeName: .kPathLength)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
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
        if let value = element.attributes?[QySVGAttributeName.kRx.rawValue], let attribute = self.attribute[QySVGAttributeName.kRx.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kRy.rawValue], let attribute = self.attribute[QySVGAttributeName.kRy.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPathLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kPathLength.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
