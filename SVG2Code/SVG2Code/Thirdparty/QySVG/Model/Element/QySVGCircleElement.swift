//
//  QySVGCircleElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGCircleElement : QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kCircle}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kCx.rawValue] = QySVGAttribute(attributeName: .kCx)
        self.attribute[QySVGAttributeName.kCy.rawValue] = QySVGAttribute(attributeName: .kCy)
        self.attribute[QySVGAttributeName.kR.rawValue] = QySVGAttribute(attributeName: .kR)
        self.attribute[QySVGAttributeName.kPathLength.rawValue] = QySVGAttribute(attributeName: .kPathLength)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kCx.rawValue], let attribute = self.attribute[QySVGAttributeName.kCx.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kCy.rawValue], let attribute = self.attribute[QySVGAttributeName.kCy.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kR.rawValue], let attribute = self.attribute[QySVGAttributeName.kR.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPathLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kPathLength.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
}
