//
//  CodeSVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/8/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

protocol CodeMaker {
    func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel)->String
    func makePath(_ svgPath: SVGPath, _ name:String, _ model:SVGDataModel) -> String
    func makeGrapth(_ name:String, _ model:SVGDataModel) -> String
    func parseModel(_ name:String, _ model:SVGDataModel) -> String
}

class CodeSVG {
    var langName = LanguageName.Swift
    var model = SVGDataModel()
    
    static let shared = CodeSVG()
    
    func update(_ lang:LanguageName, _ model:SVGDataModel){
        self.langName = lang
        self.model = model
    }
    
    func makePath(_ element:SVGDataModel, _ deep:Int)->String{
        if let text = element.element.attributes["d"] {
            let name = "path\(element.index)\(deep)"
            return langName.type().makePath(SVGPath(text), name, model)
        }
        return ""
    }
    
    func makeGrapth(_ element:SVGDataModel, _ deep:Int)->String{
        let name = "shape\(element.index)\(deep)"
        return langName.type().makeGrapth(name, model)
    }
    
    func makeRect(_ element:SVGDataModel, _ deep:Int)->String{
        if let x = element.element.attributes["x"], let y = element.element.attributes["y"], let width = element.element.attributes["width"], let height = element.element.attributes["height"]{
            let rect = CGRect(x: x.doubleValue, y: y.doubleValue, width: width.doubleValue, height: height.doubleValue)
            let name = "rect\(element.index)\(deep)"
            return langName.type().makeRect(rect, name, model)
        }
        return ""
    }
    
    func makePolygon(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeCircle(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeClipPath(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeDefs(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeEllipse(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeGlyph(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeLine(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makePolyline(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeRadialGradient(_ element:SVGDataModel, _ deep:Int)->String {
        return ""
    }
    
    func makeSvg(_ element:SVGDataModel, _ deep:Int)->String {
        return langName.type().makeGrapth(element.name, model)
    }
    
    func parseModel(_ name:String, _ model:SVGDataModel) -> String {
        return langName.type().parseModel(name, model)
    }
}
