//
//  QySVGClipPathElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGClipPathElement : QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kClipPath}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kClipPathUnits.rawValue] = QySVGAttribute(attributeName: .kClipPathUnits)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kClipPathUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kClipPathUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
