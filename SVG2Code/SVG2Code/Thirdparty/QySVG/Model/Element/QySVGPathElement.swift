//
//  QySVGPathElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGPathElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kPath}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kD.rawValue] = QySVGAttribute(attributeName: .kD)
        self.attribute[QySVGAttributeName.kPathLength.rawValue] = QySVGAttribute(attributeName: .kPathLength)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kD.rawValue], let attribute = self.attribute[QySVGAttributeName.kD.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPathLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kPathLength.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
}
