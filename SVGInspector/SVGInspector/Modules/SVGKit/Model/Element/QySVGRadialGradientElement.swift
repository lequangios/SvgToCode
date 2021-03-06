//
//  QySVGRadialGradientElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation


class QySVGRadialGradientElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kRadialGradient}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kCx.rawValue] = QySVGAttribute(attributeName: .kCx)
        self.attribute[QySVGAttributeName.kCy.rawValue] = QySVGAttribute(attributeName: .kCy)
        self.attribute[QySVGAttributeName.kFr.rawValue] = QySVGAttribute(attributeName: .kFr)
        self.attribute[QySVGAttributeName.kFx.rawValue] = QySVGAttribute(attributeName: .kFx)
        self.attribute[QySVGAttributeName.kFy.rawValue] = QySVGAttribute(attributeName: .kFy)
        self.attribute[QySVGAttributeName.kGradientUnits.rawValue] = QySVGAttribute(attributeName: .kGradientUnits)
        self.attribute[QySVGAttributeName.kGradientTransform.rawValue] = QySVGAttribute(attributeName: .kGradientTransform)
        self.attribute[QySVGAttributeName.kHref.rawValue] = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kR.rawValue] = QySVGAttribute(attributeName: .kR)
        self.attribute[QySVGAttributeName.kSpreadMethod.rawValue] = QySVGAttribute(attributeName: .kSpreadMethod)
        self.attribute[QySVGAttributeName.kXlinkHref.rawValue] = QySVGAttribute(attributeName: .kXlinkHref)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kCx.rawValue], let attribute = self.attribute[QySVGAttributeName.kCx.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kCy.rawValue], let attribute = self.attribute[QySVGAttributeName.kCy.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kFr.rawValue], let attribute = self.attribute[QySVGAttributeName.kFr.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kFx.rawValue], let attribute = self.attribute[QySVGAttributeName.kFx.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kFy.rawValue], let attribute = self.attribute[QySVGAttributeName.kFy.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kGradientUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kGradientUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kGradientTransform.rawValue], let attribute = self.attribute[QySVGAttributeName.kGradientTransform.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kR.rawValue], let attribute = self.attribute[QySVGAttributeName.kR.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kSpreadMethod.rawValue], let attribute = self.attribute[QySVGAttributeName.kSpreadMethod.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kXlinkHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kXlinkHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
