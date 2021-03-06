//
//  QySVGDefsElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGDefsElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kDefs}
    override init() {
        super.init()
    }
    override func isAcceptableChildNode(withTag tag: QySVGTag) -> Bool {
        let allowTags = (tag == .kA || tag == .kClipPath || tag == .kFilter || tag == .kForeignObject || tag == .kImage || tag == .kMarker || tag == .kMask || tag == .kScript || tag == .kStyle || tag == .kSwitch || tag == .kText || tag == .kView)
        return allowTags || tag.had(category: .kAnimationElements) || tag.had(category: .kDescriptiveElements) || tag.had(category: .kPaintServerElements) || tag.had(category: .kShapeElements) || tag.had(category: .kStructuralElements)
    }
}
