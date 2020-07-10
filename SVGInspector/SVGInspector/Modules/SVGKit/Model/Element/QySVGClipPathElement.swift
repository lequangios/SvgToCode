//
//  QySVGClipPathElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGClipPathElement : QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kClipPath}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kClipPathUnits.rawValue] = QySVGAttribute(attributeName: .kClipPathUnits)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kClipPathUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kClipPathUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
