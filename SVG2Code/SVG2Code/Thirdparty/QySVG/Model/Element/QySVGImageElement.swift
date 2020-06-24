//
//  QySVGImageElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGImageElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kImage}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
        self.attribute[QySVGAttributeName.kWidth.rawValue] = QySVGAttribute(attributeName: .kWidth)
        self.attribute[QySVGAttributeName.kHeight.rawValue] = QySVGAttribute(attributeName: .kHeight)
        self.attribute[QySVGAttributeName.kHref.rawValue] = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kXlinkHref.rawValue] = QySVGAttribute(attributeName: .kXlinkHref)
        self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] = QySVGAttribute(attributeName: .kPreserveAspectRatio)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kWidth.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kHeight.rawValue], let attribute = self.attribute[QySVGAttributeName.kHeight.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kXlinkHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kXlinkHref.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPreserveAspectRatio.rawValue], let attribute = self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
}
