//
//  QySVGLinearGradientElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGLinearGradientElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kLinearGradient}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kGradientUnits.rawValue] = QySVGAttribute(attributeName: .kGradientUnits)
        self.attribute[QySVGAttributeName.kGradientTransform.rawValue] = QySVGAttribute(attributeName: .kGradientTransform)
        self.attribute[QySVGAttributeName.kHref.rawValue] = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kSpreadMethod.rawValue] = QySVGAttribute(attributeName: .kSpreadMethod)
        self.attribute[QySVGAttributeName.kX1.rawValue] = QySVGAttribute(attributeName: .kX1)
        self.attribute[QySVGAttributeName.kX2.rawValue] = QySVGAttribute(attributeName: .kX2)
        self.attribute[QySVGAttributeName.kXlinkHref.rawValue] = QySVGAttribute(attributeName: .kXlinkHref)
        self.attribute[QySVGAttributeName.kY1.rawValue] = QySVGAttribute(attributeName: .kY1)
        self.attribute[QySVGAttributeName.kY2.rawValue] = QySVGAttribute(attributeName: .kY2)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kGradientUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kGradientUnits.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kGradientTransform.rawValue], let attribute = self.attribute[QySVGAttributeName.kGradientTransform.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kSpreadMethod.rawValue], let attribute = self.attribute[QySVGAttributeName.kSpreadMethod.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kX1.rawValue], let attribute = self.attribute[QySVGAttributeName.kX1.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kX2.rawValue], let attribute = self.attribute[QySVGAttributeName.kX2.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kXlinkHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kXlinkHref.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY1.rawValue], let attribute = self.attribute[QySVGAttributeName.kY1.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY2.rawValue], let attribute = self.attribute[QySVGAttributeName.kY2.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
}
