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
        let str = String(repeating: "✦✦", count: deep)
        var model = element
        if element.element.name == SVGElementName.circle.rawValue {
            print("\(str) \(SVGElementName.circle.rawValue) : deep \(deep)")
            model = self.makeCircle(element, deep)
        }
        else if element.element.name == SVGElementName.clipPath.rawValue {
            print("\(str) \(SVGElementName.clipPath.rawValue) : deep \(deep)")
            model = self.makeClipPath(element, deep)
        }
        else if element.element.name == SVGElementName.defs.rawValue {
            print("\(str) \(SVGElementName.defs.rawValue) : deep \(deep)")
            model = self.makeDefs(element, deep)
        }
        else if element.element.name == SVGElementName.ellipse.rawValue {
            print("\(str) \(SVGElementName.ellipse.rawValue) : deep \(deep)")
            model = self.makeEllipse(element, deep)
        }
        else if element.element.name == SVGElementName.g.rawValue {
            model = self.makeGraph(element, deep)
            print("\(str) \(SVGElementName.g.rawValue) : deep \(deep)\n\(model.code)")
        }
        else if element.element.name == SVGElementName.glyph.rawValue {
            model = self.makeGlyph(element, deep)
            print("\(str) \(SVGElementName.glyph.rawValue) : deep \(deep)")
        }
        else if element.element.name == SVGElementName.line.rawValue {
            model = self.makeLine(element, deep)
            print("\(str) \(SVGElementName.line.rawValue) : deep \(deep)")
        }
        else if element.element.name == SVGElementName.path.rawValue {
            model = self.makePath(element, deep)
            print("\(str) \(SVGElementName.path.rawValue) : deep \(deep)\n \(model.code)")
        }
        else if element.element.name == SVGElementName.polygon.rawValue {
            model = self.makePolygon(element, deep)
            print("\(str) \(SVGElementName.polygon.rawValue) : deep \(deep)")
        }
        else if element.element.name == SVGElementName.polyline.rawValue {
            model = self.makePolyline(element, deep)
            print("\(str) \(SVGElementName.polyline.rawValue) : deep \(deep)")
        }
        else if element.element.name == SVGElementName.radialGradient.rawValue {
            model = self.makeRadialGradient(element, deep)
            print("\(str) \(SVGElementName.radialGradient.rawValue) : deep \(deep)")
        }
        else if element.element.name == SVGElementName.rect.rawValue {
            model = self.makeRect(element, deep)
            print("\(str) \(SVGElementName.rect.rawValue) : deep \(deep)\n\(model.code)")
        }
        else if element.element.name == SVGElementName.svg.rawValue {
            model = self.makeSvg(element, deep)
            print("\(str) \(SVGElementName.svg.rawValue) : deep \(deep)")
        }
        else if element.element.name == SVGElementName.style.rawValue {
            print("\(str) \(SVGElementName.style.rawValue) : deep \(deep)")
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
    
    func parseXML2Code(){
        xml = try! XML.parse(self.xmlString)
        
        var index:Int = 0
        let name_layer = self.nameLayer ?? "layer"
        
        for path in xml["g", "path"] {
            if let svgPath = path.attributes["d"] {
                let shape_name = "shape\(index)"
                let path_name = "path\(index)"
                
                let svg = SVGPath.init(svgPath)
                let codeStr = shape_name.applyCommandsCode(from: svg, name: path_name)
                self.code = self.code.addNewlineCode(codeStr)
                self.code = self.code.addNewlineCode("fullPath.addPath(path\(index).cgPath)")
                self.code = self.code.addNewlineCode("let shape\(index) = CAShapeLayer()")
                self.code = self.code.addNewlineCode("shape\(index).path = path\(index).cgPath")
                
                if let style = path.attributes["class"] {
                   self.code = self.code.addNewlineCode("shape\(index).fill(\"\(style)\")")
                }
                self.code = self.code.addNewlineCode("\(name_layer).addSublayer(shape\(index))\n")
                index = index + 1
            }
        }
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
