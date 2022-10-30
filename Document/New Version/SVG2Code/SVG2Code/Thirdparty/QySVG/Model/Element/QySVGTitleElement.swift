//
//  QySVGTitleElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGTitleElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kTitle}
    override init() {
        super.init()
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        
    }
}
