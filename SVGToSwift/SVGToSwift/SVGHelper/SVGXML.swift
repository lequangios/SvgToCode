//
//  SVGXML.swift
//  SVGToSwift
//
//  Created by Le Quang on 10/8/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class SVGXMLManager {
    var xmlString:String!
    var code:String!
    var cssText:String!
    var nameLayer:String!
    var xml:SwiftyXMLParser.XML.Accessor!
    var rootModel:SVGDataModel!
    var lang:LanguageName = .Swift
    
    init(_ xml:String, name:String = "layer", lang:LanguageName = .Swift) {
        self.xmlString = xml
        self.nameLayer = name
        self.code = "let \(name) = CALayer()"
        self.code = self.code.addNewlineCode("let fullPath = CGMutablePath()")
        self.lang = lang
    }
    
    //MARK:--
    //MARK: Parse XML
    func parseElements(_ elements:SVGDataModel)->SVGDataModel{
        var mutableModel = self.parseNodes(elements)
        if(mutableModel.deep > 0){
            var log = String.init(repeating: "✦✦", count: mutableModel.deep)
            log += "parsing -- index : \(mutableModel.index) + deep : \(mutableModel.deep) + name : \(mutableModel.name)"
            print(log)
        }
        
        
        if mutableModel.element.childElements.count > 0  {
            for (index, ele) in mutableModel.element.childElements.enumerated() {
                var model = SVGDataModel.init(element: ele, index: index, code: "")
                model.parentName = mutableModel.name
                model.index = index
                model.frame = mutableModel.frame
                if(mutableModel.deep < 0){
                    model.deep = 1
                    model.name = mutableModel.name
                }
                else {
                    model.deep = mutableModel.deep + 1
                }
                
                let newModel = self.parseElements(model)
                mutableModel.childs.append(newModel)
            }
        }
        return mutableModel
    }
    
    func parseNodes(_ element:SVGDataModel) -> SVGDataModel{
        var model = element.clone()
        
        if model.element.name == SVGElementName.circle.rawValue {
            model = self.makeCircle(model)
            model.type = .circle
        }
        else if model.element.name == SVGElementName.clipPath.rawValue {
            model = self.makeClipPath(model)
            model.type = .clipPath
        }
        else if model.element.name == SVGElementName.defs.rawValue {
            
            model = self.makeDefs(model)
            model.type = .defs
        }
        else if model.element.name == SVGElementName.ellipse.rawValue {
            
            model = self.makeEllipse(model)
            model.type = .ellipse
        }
        else if model.element.name == SVGElementName.g.rawValue {
            
            model = self.makeGraph(model)
            model.type = .g
        }
        else if model.element.name == SVGElementName.glyph.rawValue {
            
            model = self.makeGlyph(model)
            model.type = .glyph
        }
        else if model.element.name == SVGElementName.line.rawValue {
            
            model = self.makeLine(model)
            model.type = .line
        }
        else if model.element.name == SVGElementName.path.rawValue {
            
            model = self.makePath(model)
            model.type = .path
        }
        else if model.element.name == SVGElementName.polygon.rawValue {
            
            model = self.makePolygon(model)
            model.type = .polygon
        }
        else if model.element.name == SVGElementName.polyline.rawValue {
            
            model = self.makePolyline(model)
            model.type = .polyline
        }
        else if model.element.name == SVGElementName.radialGradient.rawValue {
            model = self.makeRadialGradient(model)
            model.type = .radialGradient
        }
        else if model.element.name == SVGElementName.rect.rawValue {
            model = self.makeRect(model)
            model.type = .rect
        }
        else if model.element.name == SVGElementName.svg.rawValue {
            model = self.makeSvg(model)
            model.type = .svg
        }
        else if model.element.name == SVGElementName.style.rawValue {
            if let text = model.element.text {
                self.cssText = text
            }
        }
        else {
            print("\(model.element.name) is not supported")
        }
        
        return model
    }
    
    func parseXMLFile(_ name:String) -> SVGDataModel{
        xml = try! XML.parse(self.xmlString)
        self.rootModel = SVGDataModel.init(name)
        self.rootModel.index = rootValue
        self.rootModel.deep = rootValue
        if let xmlElement = xml["svg"].element {
            rootModel.element = xmlElement
            return self.parseElements(rootModel)
        }
        return SVGDataModel()
    }
    
    private func makeCircle(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "path\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeCircle(model)
        return model
    }
    
    private func makeClipPath(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "path\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeClipPath(model)
        return model
    }
    
    private func makeDefs(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "path\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeDefs(model)
        return model
    }
    
    private func makeEllipse(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "path\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeEllipse(model)
        return model
    }
    
    private func makeGraph(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "shape\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeGrapth(model)
        return model
    }
    
    private func makeGlyph(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "path\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeGlyph(model)
        return model
    }
    
    private func makeLine(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "line\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeLine(model)
        return model
    }
    
    private func makePath(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "path\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makePath(model)
        return model
    }
    
    private func makePolygon(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "polygon\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makePolygon(model)
        return model
    }
    
    private func makePolyline(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "padialgradient\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makePolyline(model)
        return model
    }
    
    private func makeRadialGradient(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "polyline\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeRadialGradient(model)
        return model
    }
    
    private func makeRect(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        model.name = "rect\(model.index)\(model.deep)"
        model.code = CodeSVG.shared.makeRect(model)
        return model
    }
    
    private func makeSvg(_ element:SVGDataModel) -> SVGDataModel {
        var model = element.clone()
        if model.deep > 0{
            model.name = "svg\(model.index)\(model.deep)"
        }
        else {
            model.name = "beginLayer"
        }
        
        if let viewBox = element.element.attributes["viewBox"] {
            let numArr = viewBox.components(separatedBy: " ")
            if(numArr.count >= 4) {
                let x = numArr[0].doubleValue
                let y = numArr[1].doubleValue
                let width = numArr[2].doubleValue
                let height = numArr[3].doubleValue
                let rect = CGRect(x: x, y: y, width: width, height: height)
                model.frame = rect
                model.code = CodeSVG.shared.makeSvg(model)
            }
        }
        return model
    }
    
    private func makeStyle(_ element:SVGDataModel) -> SVGDataModel {
        let model = element.clone()
        return model
    }
    
    deinit {
        
    }
}
