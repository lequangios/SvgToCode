//
//  QySVGTitleElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGTitleElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kTitle}
    override init() {
        super.init()
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
    }
}
