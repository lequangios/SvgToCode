//
//  QySVGPolygonElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGPolygonElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kPolygon}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kPoints.rawValue] = QySVGAttribute(attributeName: .kPoints)
        self.attribute[QySVGAttributeName.kPathLength.rawValue] = QySVGAttribute(attributeName: .kPathLength)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kPoints.rawValue], let attribute = self.attribute[QySVGAttributeName.kPoints.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPathLength.rawValue], let attribute = self.attribute[QySVGAttributeName.kPathLength.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
