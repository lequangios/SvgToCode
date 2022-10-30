//
//  QySVGStyleElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGStyleElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kStyle}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kContentStyleType.rawValue] = QySVGAttribute.init(attributeName: .kContentStyleType)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let text = element.text, let attribute = self.attribute[QySVGAttributeName.kContentStyleType.rawValue] {
            attribute.setAttributeValue(value: text, priority: .inline)
        }
    }
    override func update(info text: String) {
        super.update(info: "")
    }
}
