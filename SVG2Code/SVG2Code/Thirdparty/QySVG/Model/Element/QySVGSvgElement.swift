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
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kContentScriptType.rawValue], let attribute = self.attribute[QySVGAttributeName.kContentScriptType.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kContentStyleType.rawValue], let attribute = self.attribute[QySVGAttributeName.kContentStyleType.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kHeight.rawValue], let attribute = self.attribute[QySVGAttributeName.kHeight.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPreserveAspectRatio.rawValue], let attribute = self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kVersion.rawValue], let attribute = self.attribute[QySVGAttributeName.kVersion.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kViewBox.rawValue], let attribute = self.attribute[QySVGAttributeName.kViewBox.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kWidth.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kX.rawValue], let attribute = self.attribute[QySVGAttributeName.kX.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kY.rawValue], let attribute = self.attribute[QySVGAttributeName.kY.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
    }
    override func render(fromSVGTree tree: QySVG, canvas: inout QySVGCanvas) -> String {
        let view = canvas.canvas
        var logs = ""
        if self.attribute[QySVGAttributeName.kBaseProfile.rawValue] != nil { logs = "<b>\(QySVGAttributeName.kBaseProfile.rawValue)</b> not support" }
        if self.attribute[QySVGAttributeName.kContentScriptType.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kContentScriptType.rawValue)</b> not support"}
        if self.attribute[QySVGAttributeName.kContentStyleType.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kContentStyleType.rawValue)</b> not support"}
        if self.attribute[QySVGAttributeName.kHeight.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kHeight.rawValue)</b> not support"}
        if self.attribute[QySVGAttributeName.kPreserveAspectRatio.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kPreserveAspectRatio.rawValue)</b> not support"}
        if self.attribute[QySVGAttributeName.kVersion.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kVersion.rawValue)</b> not support"}
        if let value = self.attribute[QySVGAttributeName.kViewBox.rawValue], let attrValue = value.value as? QySVGViewBoxValue {
            view.frame = CGRect(x: attrValue.value.left.doubleValue, y: attrValue.value.top.doubleValue, width: attrValue.value.right.doubleValue, height: attrValue.value.bottom.doubleValue)
        }
        if self.attribute[QySVGAttributeName.kWidth.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kWidth.rawValue)</b> not support"}
        if self.attribute[QySVGAttributeName.kX.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kX.rawValue)</b> not support"}
        if self.attribute[QySVGAttributeName.kY.rawValue] != nil {logs = "<b>\(QySVGAttributeName.kY.rawValue)</b> not support"}
        return logs
    }
}
