//
//  QySVGViewElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class QySVGViewElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kView}
    override init() {
        super.init()
    }
    override func updateNode(withElement element: QyXMLParser.Element) {
        super.updateNode(withElement: element)
    }
}
