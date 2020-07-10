//
//  QySVGScriptElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGScriptElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kScript}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kHref.rawValue] = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kType.rawValue] = QySVGAttribute(attributeName: .kType)
        self.attribute[QySVGAttributeName.kXlinkHref.rawValue] = QySVGAttribute(attributeName: .kXlinkHref)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kType.rawValue], let attribute = self.attribute[QySVGAttributeName.kType.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kXlinkHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kXlinkHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
