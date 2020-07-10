//
//  QySVGEllipseElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGEllipseElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kEllipse}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kCx.rawValue] = QySVGAttribute(attributeName: .kCx)
        self.attribute[QySVGAttributeName.kCy.rawValue] = QySVGAttribute(attributeName: .kCy)
        self.attribute[QySVGAttributeName.kRx.rawValue] = QySVGAttribute(attributeName: .kRx)
        self.attribute[QySVGAttributeName.kRy.rawValue] = QySVGAttribute(attributeName: .kRy)
        self.attribute[QySVGAttributeName.kPathLength.rawValue] = QySVGAttribute(attributeName: .kPathLength)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kCx.rawValue], let attribute = self.attribute[QySVGAttributeName.kCx.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kCy.rawValue], let attribute = self.attribute[QySVGAttributeName.kCy.rawValue] {
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
