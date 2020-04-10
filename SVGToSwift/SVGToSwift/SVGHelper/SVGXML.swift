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
    var rootModel:SVGDataModel
    var lang:LanguageName = .Swift
    
    init(_ xml:String, name:String = "layer", rootModel:SVGDataModel = SVGDataModel(), lang:LanguageName = .Swift) {
        self.xmlString = xml
        self.nameLayer = name
        self.code = "let \(name) = CALayer()"
        self.rootModel = rootModel
        self.code = self.code.addNewlineCode("let fullPath = CGMutablePath()")
        self.lang = lang
    }
    
    //MARK:--
    //MARK: Parse XML
    func parseElements(_ elements:SVGDataModel, _ deep:Int = 0)->SVGDataModel{
        var mutableModel = self.parseNodes(elements,deep)
        if elements.element.childElements.count == 0 {
            return mutableModel
        }
        else {
            for (index, ele) in elements.element.childElements.enumerated() {
                let model = SVGDataModel.init(element: ele, parentElement: elements.element, index: index, code: "")
                let newModel = self.parseElements(model, deep+1)
                mutableModel.childs.append(newModel)
            }
            return mutableModel
        }
    }
    
    func parseNodes(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel{
//        let str = String(repeating: "✦✦", count: deep)
        var model = element
        if element.element.name == SVGElementName.circle.rawValue {
            model = self.makeCircle(element, deep)
            model.type = .circle
        }
        else if element.element.name == SVGElementName.clipPath.rawValue {
            model = self.makeClipPath(element, deep)
            model.type = .clipPath
        }
        else if element.element.name == SVGElementName.defs.rawValue {
            model = self.makeDefs(element, deep)
            model.type = .defs
        }
        else if element.element.name == SVGElementName.ellipse.rawValue {
            model = self.makeEllipse(element, deep)
            model.type = .ellipse
        }
        else if element.element.name == SVGElementName.g.rawValue {
            model = self.makeGraph(element, deep)
            model.type = .g
        }
        else if element.element.name == SVGElementName.glyph.rawValue {
            model = self.makeGlyph(element, deep)
            model.type = .glyph
        }
        else if element.element.name == SVGElementName.line.rawValue {
            model = self.makeLine(element, deep)
            model.type = .line
        }
        else if element.element.name == SVGElementName.path.rawValue {
            model = self.makePath(element, deep)
            model.type = .path
        }
        else if element.element.name == SVGElementName.polygon.rawValue {
            model = self.makePolygon(element, deep)
            model.type = .polygon
        }
        else if element.element.name == SVGElementName.polyline.rawValue {
            model = self.makePolyline(element, deep)
            model.type = .polyline
        }
        else if element.element.name == SVGElementName.radialGradient.rawValue {
            model = self.makeRadialGradient(element, deep)
            model.type = .radialGradient
        }
        else if element.element.name == SVGElementName.rect.rawValue {
            model = self.makeRect(element, deep)
            model.type = .rect
        }
        else if element.element.name == SVGElementName.svg.rawValue {
            model = self.makeSvg(element, deep)
            model.type = .svg
        }
        else if element.element.name == SVGElementName.style.rawValue {
            if let text = element.element.text {
                self.cssText = text
            }
        }
        else {
            print("\(element.element.name) is not supported")
        }
        
        return model
    }
    
    func parseXMLFile() -> SVGDataModel{
        xml = try! XML.parse(self.xmlString)
        if let xmlElement = xml["svg"].element {
            let model = SVGDataModel.init(element: xmlElement, parentElement: nil, index: 0, code: "")
            return self.parseElements(model)
        }
        return SVGDataModel()
    }
    
    private func makeCircle(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeCircle(model, deep)
        return model
    }
    
    private func makeClipPath(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeClipPath(element, deep)
        return model
    }
    
    private func makeDefs(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeDefs(element, deep)
        return model
    }
    
    private func makeEllipse(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeEllipse(element, deep)
        return model
    }
    
    private func makeGraph(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeGrapth(element, deep)
        return model
    }
    
    private func makeGlyph(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeGlyph(element, deep)
        return model
    }
    
    private func makeLine(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeLine(element, deep)
        return model
    }
    
    private func makePath(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.name = "path\(element.index)\(deep)"
        model.code = CodeSVG.shared.makePath(model, deep)
        return model
    }
    
    private func makePolygon(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makePolygon(model, deep)
        return model
    }
    
    private func makePolyline(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makePolyline(model, deep)
        return model
    }
    
    private func makeRadialGradient(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.code = CodeSVG.shared.makeRadialGradient(model, deep)
        return model
    }
    
    private func makeRect(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.name = "rect\(model.index)\(deep)"
        model.code = CodeSVG.shared.makeRect(model, deep)
        return model
    }
    
    private func makeSvg(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        if let viewBox = element.element.attributes["viewBox"] {
            let numArr = viewBox.components(separatedBy: " ")
            if(numArr.count >= 4) {
                let x = numArr[0].doubleValue
                let y = numArr[1].doubleValue
                let width = numArr[2].doubleValue
                let height = numArr[3].doubleValue
                let rect = CGRect(x: x, y: y, width: width, height: height)
                model.frame = rect
                model.name = "svg\(deep)"
                model.code = CodeSVG.shared.makeSvg(model, deep)
            }
        }
        return model
    }
    
    private func makeStyle(_ element:SVGDataModel, _ deep:Int = 0) -> SVGDataModel {
        var model = element
        model.deep = deep
        model.deep = deep
        return model
    }
    
    deinit {
        
    }
}
