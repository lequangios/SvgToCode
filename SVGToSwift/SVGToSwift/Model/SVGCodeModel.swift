//
//  SVGCodeModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

typealias CodeGroup = (name:String, code:String)

class SVGDataModel {
    var id:String = ""
    var styles:[String] = []
    var style = ""
    var layerName:String?
    var element:XML.Element!
    var parentElement:XML.Element!
    var parentNode:SVGDataModel?
    var index:Int = 0
    var code:String = ""
    var deep:Int = 0
    var childs:[SVGDataModel] = []
    var frame:CGRect = .zero
    var parentName:String = ""
    var name:String = ""
    var type:SVGElementName = .g
    var referenceId = ""
    var clipPaths:[SVGDataModel] = []
    var definePaths:[SVGDataModel] = []
    var isRootNode = true
    var isMask = false
    
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
        style = model.style
        element = model.element
        parentElement = model.parentElement
        index = model.index
        code = model.code
        childs = model.childs
        frame = model.frame
        parentName = model.parentName
        parentNode = model.parentNode
        name = "copy_of_\(model.name)"
        deep = model.deep
        type = model.type
        layerName = model.layerName
        isRootNode = false
    }
    
    var parentId:String {
        if let parent = self.parentNode {
            if parent.isShape {
                return parent.name.trim(parent.type.rawValue)
            }
        }
        return ""
    }
    
    var isPath:Bool {
        return type != .g && type != .style && type != .svg && type != .radialGradient
    }
    
    var isShape:Bool {
        return type == .g || type == .svg || type == .glyph || type == .radialGradient
    }
    
    deinit {
        print("💀 deinit \(self.name) \n")
        element = nil
        childs.removeAll()
    }
}

extension SVGDataModel {
    func clone()->SVGDataModel {
        let model = SVGDataModel.init(self)
        model.childs = []
        model.code = ""
        return model
    }
    
    func printModel(_ position:String = ""){
        var log = "\(String.init(repeating: "❉", count: 15)) \(position) \(String.init(repeating: "❉", count: 15))\n"
        if(self.deep < 0) {
            log += String.init(repeating: "❤️", count: 2)
            log += "→ \(self.name)\n"
        }
        else {
            log += "→ \(self.name)\n"
        }
        if self.childs.count > 0 {
            for item in self.childs {
                log += "    ✔︎ \(item.name)\n"
            }
        }
        log += "\(String.init(repeating: "❉", count: 30))\n"
        print(log)
    }
    
    func addClipPath(_ model:SVGDataModel){
        if self.isRootNode == true {
            self.clipPaths.append(model)
        }
        else if let parent = self.parentNode {
            parent.addClipPath(model)
        }
    }
    
    func addDefine(_ model:SVGDataModel){
        if self.isRootNode == true {
            self.definePaths.append(model)
        }
        else if let parent = self.parentNode {
            parent.addDefine(model)
        }
    }
    
    func getShapeAttributeModel(_ style:StyleSheet) -> ShapeAttributeModel {
        let styles = self.style.arraySubString(" ")
        var shapeAttribute:ShapeAttributeModel
        
        if styles.count > 0 {
            let selector = SVGStyleElement(styles, style)
            shapeAttribute = selector.getShapeAttributeModel(self)
        }
        else {
            shapeAttribute = ShapeAttributeModel(self)
        }
        return shapeAttribute
    }
    
    func getPathAttributeModel(_ style:StyleSheet) -> PathAttributeModel {
        let styles = self.style.arraySubString(" ")
        var pathAttribute:PathAttributeModel
        
        if styles.count > 0 {
            let selector = SVGStyleElement(styles, style)
            pathAttribute = selector.getPathAttributeModel(self)
        }
        else {
            pathAttribute = PathAttributeModel(self)
        }
        
        return pathAttribute
    }
    
    func getShapeStyle(_ style:StyleSheet, _ priority:Int) -> ShapeStyleModel? {
        let styles = self.style.arraySubString(" ")
        if styles.count > 0 {
            let selector = SVGStyleElement(styles, style)
            let shape = ShapeStyleModel(selector, priority)
            return shape
        }
        else {
           return nil
        }
    }
    
    func getStyleList(_ style:StyleSheet) -> [ShapeStyleModel] {
        var styles:[ShapeStyleModel] = []
        
        // Get style in attributte element
        styles.append(ShapeStyleModel(self.element, 0))
        
        // Get style in css
        if let css = self.getShapeStyle(style, 1) {
            styles.append(css)
        }
        
        // Get style in parent
        if let parent = self.element.parentElement {
            // Get style in attributte element
            styles.append(ShapeStyleModel(parent, 3))
            
            // Get style in css
            if let parentnode = self.parentNode, let css = parentnode.getShapeStyle(style, 4) {
                styles.append(css)
            }
        }
        
        return styles
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
