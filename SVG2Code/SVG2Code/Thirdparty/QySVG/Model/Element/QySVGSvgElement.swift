//
//  QySVGSvgElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGSvgElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kSvg}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kBaseProfile.rawValue] = QySVGAttribute(attributeName: .kBaseProfile)
        self.attribute[QySVGAttributeName.kContentScriptType.rawValue] = QySVGAttribute(attributeName: .kContentScriptType)
        self.attribute[QySVGAttributeName.kContentStyleType.rawValue] = QySVGAttribute(attributeName: .kContentStyleType)
        self.attribute[QySVGAttributeName.kHeight.rawValue] = QySVGAttribute(attributeName: .kHeight)
        self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] = QySVGAttribute(attributeName: .kPreserveAspectRatio)
        self.attribute[QySVGAttributeName.kVersion.rawValue] = QySVGAttribute(attributeName: .kVersion)
        self.attribute[QySVGAttributeName.kViewBox.rawValue] = QySVGAttribute(attributeName: .kViewBox)
        self.attribute[QySVGAttributeName.kWidth.rawValue] = QySVGAttribute(attributeName: .kWidth)
        self.attribute[QySVGAttributeName.kX.rawValue] = QySVGAttribute(attributeName: .kX)
        self.attribute[QySVGAttributeName.kY.rawValue] = QySVGAttribute(attributeName: .kY)
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        if let value = element.attributes[QySVGAttributeName.kBaseProfile.rawValue], let attribute = self.attribute[QySVGAttributeName.kBaseProfile.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kContentScriptType.rawValue], let attribute = self.attribute[QySVGAttributeName.kContentScriptType.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kContentStyleType.rawValue], let attribute = self.attribute[QySVGAttributeName.kContentStyleType.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kHeight.rawValue], let attribute = self.attribute[QySVGAttributeName.kHeight.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPreserveAspectRatio.rawValue], let attribute = self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kVersion.rawValue], let attribute = self.attribute[QySVGAttributeName.kVersion.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kViewBox.rawValue], let attribute = self.attribute[QySVGAttributeName.kViewBox.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kWidth.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
}
