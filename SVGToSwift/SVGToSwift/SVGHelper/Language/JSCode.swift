//
//  JSCode.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftSoup

final class JSCode : CodeMaker{    
    static let shared = JSCode()
    
    internal func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel = SVGDataModel())->String{
       return ""
   }
    
    internal func makePath(_ svgPath: SVGPath, _ name:String, _ model:SVGDataModel = SVGDataModel()) -> String {
        return ""
    }
    
    func makeGrapth(_ name: String, _ model: SVGDataModel) -> String {
        return "12"
    }
}
