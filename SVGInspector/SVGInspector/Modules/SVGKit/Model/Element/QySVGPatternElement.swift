//
//  QySVGPatternElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGPatternElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kPattern}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kHeight.rawValue] = QySVGAttribute(attributeName: .kHeight)
        self.attribute[QySVGAttributeName.kHref.rawValue] = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kPatternContentUnits.rawValue] = QySVGAttribute(attributeName: .kPatternContentUnits)
        self.attribute[QySVGAttributeName.kPatternTransform.rawValue] = QySVGAttribute(attributeName: .kPatternTransform)
        self.attribute[QySVGAttributeName.kPatternUnits.rawValue] = QySVGAttribute(attributeName: .kPatternUnits)
        self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] = QySVGAttribute(attributeName: .kPreserveAspectRatio)
        self.attribute[QySVGAttributeName.kViewBox.rawValue] = QySVGAttribute(attributeName: .kViewBox)
        self.attribute[QySVGAttributeName.kWidth.rawValue] = QySVGAttribute(attributeName: .kWidth)
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kXlinkHref.rawValue] = QySVGAttribute(attributeName: .kXlinkHref)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kHeight.rawValue], let attribute = self.attribute[QySVGAttributeName.kHeight.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPatternContentUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kPatternContentUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPatternTransform.rawValue], let attribute = self.attribute[QySVGAttributeName.kPatternTransform.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPatternUnits.rawValue], let attribute = self.attribute[QySVGAttributeName.kPatternUnits.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPreserveAspectRatio.rawValue], let attribute = self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kViewBox.rawValue], let attribute = self.attribute[QySVGAttributeName.kViewBox.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kWidth.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kXlinkHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kXlinkHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
}
