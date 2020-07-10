//
//  QySVGCircleElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGCircleElement : QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kCircle}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kCx.rawValue] = QySVGAttribute(attributeName: .kCx)
        self.attribute[QySVGAttributeName.kCy.rawValue] = QySVGAttribute(attributeName: .kCy)
        self.attribute[QySVGAttributeName.kR.rawValue] = QySVGAttribute(attributeName: .kR)
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
        if let value = element.attributes?[QySVGAttributeName.kR.rawValue], let attribute = self.attribute[QySVGAttributeName.kR.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPathLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kPathLength.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
