//
//  SVGCodeModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

struct SVGDataModel {
    var element:XML.Element!
    var parentElement:XML.Element!
    var index:Int = 0
    var code:String = ""
    var deep:Int = 0
    var childs:[SVGDataModel] = []
    var frame:CGRect = .zero
    var parentName:String = ""
    var name:String = ""
}
