//
//  CodeSVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/8/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

protocol CodeMaker {
    func makeCircle(_ model: SVGDataModel, _ center:CGPoint, _ radius:Double) -> String
    func makeClipPath(_ model:SVGDataModel, childs:[CodeGroup])->String
    func makeDefs(_ model:SVGDataModel)->String
    func makeEllipse(_ model: SVGDataModel, _ center:CGPoint, _ radius1:Double, _ radius2:Double)->String
    func makeGlyph(_ model:SVGDataModel)->String
    func makeLine(_ model: SVGDataModel, _ point1:CGPoint, _ point2:CGPoint) -> String
    func makePolyline(_ model:SVGDataModel, _ points:[CGPoint])->String
    func makeRadialGradient(_ model:SVGDataModel, _ colors:[String], _ locations:[NSNumber], _ point:CGPoint, _ radius:Double)->String
    func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel)->String
    func makePath(_ svgPath: SVGPath, _ name:String, _ model:SVGDataModel) -> String
    func makePolygon(_ model:SVGDataModel, _ points:[CGPoint])->String
    func makeSVG(_ model:SVGDataModel)->String
    func makeGrapth(_ name:String, _ model:SVGDataModel) -> String
    func parseModel(_ model:SVGDataModel, _ style:StyleSheet, _ deep:Int) -> String
}

class CodeSVG {
    var langName = LanguageName.Swift
    var model = SVGDataModel()
    
    static let shared = CodeSVG()
    
    func update(_ lang:LanguageName, _ model:SVGDataModel){
        self.langName = lang
        self.model = model
    }
    
    func makePath(_ element:SVGDataModel)->String{
        if let text = element.element.attributes["d"] {
            return langName.type().makePath(SVGPath(text), element.name, element)
        }
        return ""
    }
    
    func makeGrapth(_ element:SVGDataModel)->String{
        return langName.type().makeGrapth(element.name, element)
    }
    
    func makeRect(_ element:SVGDataModel)->String{
        let x = element.element.attributes["x"] ?? "0"
        let y = element.element.attributes["y"] ?? "0"
        
        if let width = element.element.attributes["width"], let height = element.element.attributes["height"]{
            let rect = CGRect(x: x.doubleValue, y: y.doubleValue, width: width.doubleValue, height: height.doubleValue)
            return langName.type().makeRect(rect, element.name, element)
        }
        return ""
    }
    
    func makePolygon(_ element:SVGDataModel)->String {
        if let points = element.element.attributes["points"]{
            let arrPointStr = points.split(separator: " ")
            if arrPointStr.count > 0 {
                var ps:[CGPoint] = []
                for item in arrPointStr {
                    let p = item.split(separator: ",")
                    if p.count > 1 {
                        let x = CGPoint(x: String(p[0]).doubleValue, y: String(p[1]).doubleValue)
                        ps.append(x)
                    }
                }
                return langName.type().makePolygon(element, ps)
            }
        }
        return ""
    }
    
    func makeCircle(_ element:SVGDataModel)->String {
        let x = element.element.attributes["cx"] ?? "0"
        let y = element.element.attributes["cy"] ?? "0"
        let point = CGPoint(x: x.doubleValue, y: y.doubleValue)
        if let radius = element.element.attributes["r"] {
            return langName.type().makeCircle(element, point, radius.doubleValue)
        }
        return ""
    }
    
    // layer.mask = maskLayer
    func makeClipPath(_ element:SVGDataModel, childs:[CodeGroup])->String {
        return ""
    }
    
    func makeDefs(_ element:SVGDataModel)->String {
        return ""
    }
    
    func makeEllipse(_ element:SVGDataModel)->String {
        let x = element.element.attributes["cx"] ?? "0"
        let y = element.element.attributes["cy"] ?? "0"
        let rx = element.element.attributes["rx"] ?? "0"
        let ry = element.element.attributes["ry"] ?? "0"
        let point = CGPoint.init(x: x.doubleValue, y: y.doubleValue)
        return langName.type().makeEllipse(element, point, rx.doubleValue, ry.doubleValue)
    }
    
    func makeGlyph(_ element:SVGDataModel)->String {
        return ""
    }
    
    func makeLine(_ element:SVGDataModel)->String {
        let x1 = element.element.attributes["x1"] ?? "0"
        let y1 = element.element.attributes["y1"] ?? "0"
        let x2 = element.element.attributes["x2"] ?? "0"
        let y2 = element.element.attributes["y2"] ?? "0"
        let p1 = CGPoint(x: x1.doubleValue, y: y1.doubleValue)
        let p2 = CGPoint(x: x2.doubleValue, y: y2.doubleValue)
        return langName.type().makeLine(element, p1, p2)
    }
    
    func makePolyline(_ element:SVGDataModel)->String {
        if let points = element.element.attributes["points"]{
            let arrPointStr = points.split(separator: " ")
            if arrPointStr.count > 0 {
                var ps:[CGPoint] = []
                for item in arrPointStr {
                    let p = item.split(separator: ",")
                    if p.count > 1 {
                        let x = CGPoint(x: String(p[0]).doubleValue, y: String(p[1]).doubleValue)
                        ps.append(x)
                    }
                }
                return langName.type().makePolyline(element, ps)
            }
        }
        return ""
    }
    
    func makeRadialGradient(_ element:SVGDataModel)->String {
        let x = element.element.attributes["cx"] ?? "0"
        let y = element.element.attributes["cy"] ?? "0"
        let radius = element.element.attributes["r"] ?? "0"
        var colors = [String]()
        var locations = [NSNumber]()
        let point = CGPoint(x: x.doubleValue, y: y.doubleValue)
        for ele in element.element.childElements {
            let offset = ele.attributes["offset"] ?? "0"
            let style = ele.attributes["style"] ?? ""
            let color = style.split(separator: ":")
            if(color.count >= 2) {
                colors.append(String(color[1]))
            }
            locations.append(NSNumber(value: offset.doubleValue))
        }
        return langName.type().makeRadialGradient(element, colors, locations, point, radius.doubleValue)
    }
    
    func makeSvg(_ element:SVGDataModel)->String {
        return langName.type().makeSVG(element)
    }
    
    func parseModel(_ name:String, _ element:SVGDataModel, _ style:StyleSheet) -> String {
        return langName.type().parseModel(element, style, 0)
    }
}
