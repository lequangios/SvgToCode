//
//  QySVGViewElement.swift
//  SVG2Code
//
//  Created by Le Quang on 6/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class QySVGViewElement: QySVGNode {
    override var tag: QySVGTag { return  QySVGTag.kView}
    override init() {
        super.init()
    }
    override func updateNode(byElement element: XML.Element, index: Int, deep: Int) {
        super.updateNode(byElement: element, index: index, deep: deep)
        
    }
}
