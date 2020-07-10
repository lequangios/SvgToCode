//
//  QySVGAElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGAElement : QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kA}
    override init() {
        super.init()
        self.attribute[QySVGAttributeName.kHref.rawValue]           = QySVGAttribute(attributeName: .kHref)
        self.attribute[QySVGAttributeName.kHreflang.rawValue]       = QySVGAttribute(attributeName: .kHreflang)
        self.attribute[QySVGAttributeName.kPing.rawValue]           = QySVGAttribute(attributeName: .kPing)
        self.attribute[QySVGAttributeName.kReferrerPolicy.rawValue] = QySVGAttribute(attributeName: .kReferrerPolicy)
        self.attribute[QySVGAttributeName.kRel.rawValue]            = QySVGAttribute(attributeName: .kRel)
        self.attribute[QySVGAttributeName.kTarget.rawValue]         = QySVGAttribute(attributeName: .kTarget)
        self.attribute[QySVGAttributeName.kType.rawValue]           = QySVGAttribute(attributeName: .kType)
        self.attribute[QySVGAttributeName.kXlinkHref.rawValue]      = QySVGAttribute(attributeName: .kXlinkHref)
    }
    override func isAcceptableChildNode(withTag tag: QySVGTag) -> Bool {
        let allowTags = (tag == .kA || tag == .kClipPath || tag == .kFilter || tag == .kForeignObject || tag == .kImage || tag == .kMarker || tag == .kMask || tag == .kScript || tag == .kStyle || tag == .kSwitch || tag == .kText || tag == .kView)
        return allowTags || tag.had(category: .kAnimationElements) || tag.had(category: .kDescriptiveElements) || tag.had(category: .kPaintServerElements) || tag.had(category: .kShapeElements) || tag.had(category: .kStructuralElements)
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
        if let value = element.attributes?[QySVGAttributeName.kHref.rawValue], let attribute = self.attribute[QySVGAttributeName.kHref.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kHreflang.rawValue], let attribute = self.attribute[QySVGAttributeName.kHreflang.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kPing.rawValue], let attribute = self.attribute[QySVGAttributeName.kPing.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kReferrerPolicy.rawValue], let attribute = self.attribute[QySVGAttributeName.kReferrerPolicy.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kRel.rawValue], let attribute = self.attribute[QySVGAttributeName.kRel.rawValue] {
            attribute.setAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes?[QySVGAttributeName.kTarget.rawValue], let attribute = self.attribute[QySVGAttributeName.kTarget.rawValue] {
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
