//
//  SVGNodeModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

typealias SVGNodeChildPathInfo = (isOnePath:Bool, isMultiPath:Bool)

class SVGNodeModel {
    var id:String = ""
    var description:String = ""
    var styles:[String] = []
    var index:Int = 0
    var deep:Int = 0
    var clipPathURL = ""
    var isMask = false
    var name:String { return "\(type.rawValue)\(index)" }
    var shapeName:String { return "shape\(index)" }
    var maskName:String { return "mask\(index)" }
    var pathName:String { return "path\(index)" }
    var dataTxt:String = ""
    var zPosition:CGFloat {
        //return CGFloat(type.priority())
        return CGFloat(index)
    }
    //var zPosition:CGFloat { return CGFloat(type.priority()) }
    var nodeData:Any?
    var parentType:SVGElementName = .g
    
    var isPath:Bool {
        return type.isPath()
    }
    
    var isShape:Bool {
        return type.isShape()
    }
    
    var type:SVGElementName = .g
    weak var parentNode:SVGNodeModel?
    weak var defReferenceNode:SVGNodeModel? // Use for Def, Use, Clippath
    weak var clipPathReferenceNode:SVGNodeModel? // Use for Def, Use, Clippath
    var childs:[SVGNodeModel] = []
    var attributes:[SVGElementAttribute] = []
    
    public var memorySize:Int {
        return MemoryLayout<SVGNodeModel>.stride
    }
    
    init(index:Int, deep:Int) {
        self.deep = deep
        self.index = index
        self.description = "new model"
    }
    
    func isOnlyOneChildPath()-> SVGNodeChildPathInfo {
        let lists = childs.findPaths()
        return (lists.count == 1,lists.count >= 2)
    }
    
    func update(element:XML.Element){
        self.description = "\(description) --> update with \(element.name)"
        self.type = SVGElementName.init(rawValue: element.name) ?? SVGElementName.unsuported
        if let style = element.attributes["class"] {
            self.styles = style.arraySubString(" ")
        }
        
        if let clippath = element.attributes["clip-path"] {
            self.clipPathURL = clippath.dropValueFromURLValue
        }
        
        updateAttribute(element)
        
        switch type {
        case .rect:
            makeRect(element)
            break
        case .path:
            makePath(element)
            break
        case .circle:
            makeCircle(element)
            break
        case .ellipse:
            makeEllipse(element)
            break
        case .line:
            makeLine(element)
            break
        case .polyline:
            makePolyline(element)
            break
        case .polygon:
            makePolygon(element)
            break
        case .radialGradient:
            makeRadialGradient(element)
            break
        case .text:
            makeText(element)
            break
        case .use:
            makeUse(element)
            break
        case .glyph:
            makeGlyph(element)
            break
        case .clipPath:
            makeClipPath(element)
            break
        case .g:
            makeGraph(element)
            break
        case .svg:
            makeSVG(element)
            break
        case .defs:
            makeDefs(element)
            break
        case .style:
            makeStyle(element)
            break
        default:
            print("\(type.rawValue) is not support")
            break
        }
    }
    
    func updateAttribute(_ element:XML.Element){
        let attr1 = SVGElementAttribute(element, StylePriority.ElementAttribute.rawValue)
        self.attributes.append(attr1)
        if let parentElement = element.parentElement {
            let attr2 =  SVGElementAttribute(parentElement, StylePriority.ParentElementAttribute.rawValue)
            self.attributes.append(attr2)
        }
    }
    
    func updateCSSStyle(_ stylesheet:StyleSheet){
        if styles.count > 0 {
            let attr1 = SVGElementAttribute(SVGStyleElement(styles, stylesheet), StylePriority.ElementClass.rawValue)
            self.attributes.append(attr1)
        }
        
        if let parent = parentNode, parent.styles.count > 0 {
            let attr2 = SVGElementAttribute(SVGStyleElement(parent.styles, stylesheet), StylePriority.ElementClass.rawValue)
            self.attributes.append(attr2)
        }
    }
    
    func computingAttribute(_ stylesheet:StyleSheet) -> SVGElementAttribute {
        updateCSSStyle(stylesheet)
        return attributes.getLastStyle()
    }
    
    func clone() {
        let newModel            = SVGNodeModel(index: self.index, deep: self.deep)
        newModel.id             = self.id
        newModel.styles         = self.styles
        newModel.clipPathURL    = self.clipPathURL
        newModel.isMask         = self.isMask
        newModel.dataTxt        = self.dataTxt
        newModel.type           = self.type
        newModel.parentNode     = self.parentNode
        newModel.childs         = self.childs
        newModel.description            = "\(self.description) --> clone from \(self.id)"
    }
    
    deinit {
        childs.removeAll()
    }
}

//MARK:--
//MARK: Parse XML Element
extension SVGNodeModel {
    func makeStyle(_ element:XML.Element){
        dataTxt = element.text ?? ""
    }
    
    func makeRect(_ element:XML.Element){
        let x = element.attributes["x"] ?? "0"
        let y = element.attributes["y"] ?? "0"
        
        if let width = element.attributes["width"], let height = element.attributes["height"]{
            let rect = CGRect(x: x.doubleValue, y: y.doubleValue, width: width.doubleValue, height: height.doubleValue)
            self.nodeData = rect
        }
    }
    
    func makePath(_ element:XML.Element){
        if let text = element.attributes["d"] {
            let data = SVGPath(text)
            self.nodeData = data
        }
    }
    
    func makeCircle(_ element:XML.Element){
        let x = element.attributes["cx"] ?? "0"
        let y = element.attributes["cy"] ?? "0"
        let point = CGPoint(x: x.doubleValue, y: y.doubleValue)
        if let radius = element.attributes["r"] {
            let data:SVGCircle = (point, radius.doubleValue)
            self.nodeData = data
        }
    }
    
    func makeEllipse(_ element:XML.Element) {
        let x = element.attributes["cx"] ?? "0"
        let y = element.attributes["cy"] ?? "0"
        let rx = element.attributes["rx"] ?? "0"
        let ry = element.attributes["ry"] ?? "0"
        let data:SVGEllipse = (CGPoint(x: x.doubleValue, y: y.doubleValue), rx.doubleValue, ry.doubleValue)
        self.nodeData = data
    }
    
    func makeLine(_ element:XML.Element) {
        let x1 = element.attributes["x1"] ?? "0"
        let y1 = element.attributes["y1"] ?? "0"
        let x2 = element.attributes["x2"] ?? "0"
        let y2 = element.attributes["y2"] ?? "0"
        let p1 = CGPoint(x: x1.doubleValue, y: y1.doubleValue)
        let p2 = CGPoint(x: x2.doubleValue, y: y2.doubleValue)
        let data:SVGLine = (p1, p2)
        self.nodeData = data
    }
    
    func makePolyline(_ element:XML.Element) {
        if let points = element.attributes["points"]{
            let arrPointStr = points.split(separator: " ")
            if arrPointStr.count > 0 {
                var ps:SVGPolyline = []
                for item in arrPointStr {
                    let p = item.split(separator: ",")
                    if p.count > 1 {
                        let x = CGPoint(x: String(p[0]).doubleValue, y: String(p[1]).doubleValue)
                        ps.append(x)
                    }
                }
                self.nodeData = ps
            }
        }
    }
    
    func makePolygon(_ element:XML.Element) {
        if let points = element.attributes["points"]{
            let arrPointStr = points.split(separator: " ")
            if arrPointStr.count > 0 {
                var ps:SVGPolyline = []
                for item in arrPointStr {
                    let p = item.split(separator: ",")
                    if p.count > 1 {
                        let x = CGPoint(x: String(p[0]).doubleValue, y: String(p[1]).doubleValue)
                        ps.append(x)
                    }
                }
                self.nodeData = ps
            }
        }
    }
    
    func makeRadialGradient(_ element:XML.Element) {
        let x = element.attributes["cx"] ?? "0"
        let y = element.attributes["cy"] ?? "0"
        let radius = element.attributes["r"] ?? "0"
        var colors:Array<String> = []
        var locations:Array<NSNumber> = []
        let point = CGPoint(x: x.doubleValue, y: y.doubleValue)
        for ele in element.childElements {
            let offset = ele.attributes["offset"] ?? "0"
            let style = ele.attributes["style"] ?? ""
            let color = style.split(separator: ":")
            if(color.count >= 2) {
                colors.append(String(color[1]))
            }
            locations.append(NSNumber(value: offset.doubleValue))
        }
        let data:SVGRadialGradient = (colors, locations, point, radius.doubleValue)
        self.nodeData = data
    }
    
    func makeText(_ element:XML.Element){
        let x = element.attributes["x"] ?? "0"
        let y = element.attributes["y"] ?? "0"
        let text = element.text ?? ""
        let data:SVGText = (CGPoint.init(x: x.doubleValue, y: y.doubleValue), text)
        self.nodeData = data
    }
    
    func makeUse(_ element:XML.Element) {
        var data:SVGUse = ("", CGPoint.zero, CGSize.zero)
        if let href = element.attributes["href"] {
            data.href = href.dropValueFromURLValue
        }
        else if let xlinkhref = element.attributes["xlink:href"] {
            print("☠️ xlink:href is deprecated")
            data.href = xlinkhref.dropValueFromURLValue
        }
        
        let x = element.attributes["x"] ?? "0"
        let y = element.attributes["y"] ?? "0"
        let width = element.attributes["width"] ?? "0"
        let height = element.attributes["height"] ?? "0"
        
        data.p = CGPoint.init(x: x.doubleValue, y: y.doubleValue)
        data.size = CGSize(width: width.doubleValue, height: height.doubleValue)
        
        self.nodeData = data
    }
    
    func makeGraph(_ element:XML.Element) {
        // Do nothing
    }
    
    func makeSVG(_ element:XML.Element) {
        if let viewBox = element.attributes["viewBox"] {
            let numArr = viewBox.components(separatedBy: " ")
            if(numArr.count >= 4) {
                let x = numArr[0].doubleValue
                let y = numArr[1].doubleValue
                let width = numArr[2].doubleValue
                let height = numArr[3].doubleValue
                let rect1 = CGRect(x: x, y: y, width: width, height: height)
                
                let x1 = element.attributes["x"] ?? "0"
                let y1 = element.attributes["y"] ?? "0"
                let w1 = element.attributes["width"] ?? numArr[2]
                let h1 = element.attributes["height"] ?? numArr[3]
                
                let rect2 = CGRect.init(x: x1.doubleValue, y: y1.doubleValue, width: w1.doubleValue, height: h1.doubleValue)
                
                let data:SVG = (rect1, rect2)
                self.nodeData = data
            }
        }
    }
    
    func makeGlyph(_ element:XML.Element) {
        print("☠️ glyph is deprecated")
    }
    
    func makeClipPath(_ element:XML.Element) {
        let id = element.attributes["id"] ?? ""
        let clipPathUnits = element.attributes["clipPathUnits"] ?? ""
        let data:SVGClipPath = (id, clipPathUnits)
        self.nodeData = data
    }
    
    func makeDefs(_ element:XML.Element) {
        // Do nothing
        let id = element.attributes["id"] ?? ""
        self.id = id
    }
}

//MARK:--
//MARK: List SVGNodeModel

extension Array where Element == SVGNodeModel {
    func findPaths()->[SVGNodeModel] {
        return self.filter{$0.type != .g && $0.type != .style && $0.type != .svg}
    }
    
    func findShape()->[SVGNodeModel] {
        return self.filter{$0.type == .g || $0.type == .svg}
    }
    func findStyle()->[SVGNodeModel]{
        return self.filter{$0.type == .style}
    }
}

