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
    var id:String = ""
    var styles:[String] = []
    var element:XML.Element!
    var parentElement:XML.Element!
    var index:Int = 0
    var code:String = ""
    var deep:Int = 0
    var childs:[SVGDataModel] = []
    var frame:CGRect = .zero
    var parentName:String = ""
    var name:String = ""
    var type:SVGElementName = .g
    
    init(){
        name = "no-name"
    }
    
    init(element:XML.Element, index:Int, code:String=""){
        self.element = element
        self.parentElement = element.parentElement
        self.index = index
        self.code = code
    }
    
    init(_ name:String){
        self.name = name
    }
    
    init(_ model:SVGDataModel){
        id = model.id
        styles = model.styles
        element = model.element
        parentElement = model.parentElement
        index = model.index
        code = model.code
        childs = model.childs
        frame = model.frame
        parentName = model.parentName
        name = "copy_of_\(model.name)"
        deep = model.deep
        type = model.type
        
    }
}

extension SVGDataModel {
    func clone()->SVGDataModel { return SVGDataModel.init(self) }
    
    func printModel(){
        if(self.deep < 0) {
            var log = String.init(repeating: "💣", count: 2)
            log += " scaning -- \(self.name)"
            print(log)
        }
        else {
            var log = String.init(repeating: "✦✦", count: self.deep)
            log += " scaning -- \(self.name)"
            print(log)
        }
        
    }
}

extension Array where Element == SVGDataModel {
    func findPaths()->[SVGDataModel] {
        return self.filter{$0.type != .g && $0.type != .style && $0.type != .svg}
    }
    
    func findShape()->[SVGDataModel] {
        return self.filter{$0.type == .g || $0.type == .svg}
    }
    func findStyle()->[SVGDataModel]{
        return self.filter{$0.type == .style}
    }
}
