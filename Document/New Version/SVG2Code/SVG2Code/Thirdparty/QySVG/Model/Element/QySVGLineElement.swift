//
//  QySVGLineElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGLineElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kLine}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kX1.rawValue] = QySVGAttribute(attributeName: .kX1)
        self.attribute[QySVGAttributeName.kX2.rawValue] = QySVGAttribute(attributeName: .kX2)
        self.attribute[QySVGAttributeName.kY1.rawValue] = QySVGAttribute(attributeName: .kY1)
        self.attribute[QySVGAttributeName.kY2.rawValue] = QySVGAttribute(attributeName: .kY2)
        self.attribute[QySVGAttributeName.kPathLength.rawValue] = QySVGAttribute(attributeName: .kPathLength)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kX1.rawValue], let attribute = self.attribute[QySVGAttributeName.kX1.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kX2.rawValue], let attribute = self.attribute[QySVGAttributeName.kX2.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY1.rawValue], let attribute = self.attribute[QySVGAttributeName.kY1.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY2.rawValue], let attribute = self.attribute[QySVGAttributeName.kY2.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPathLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kPathLength.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
