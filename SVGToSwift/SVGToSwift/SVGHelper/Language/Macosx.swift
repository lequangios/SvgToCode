//
//  Macosx.swift
//  SVGToSwift
//
//  Created by Le Quang on 5/1/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics

class MacosxCodeNode: NodeProtocol {
    var model:SVGDataModel
    var deep:Int = 0
    var index:Int = 0
    var isOnePath = true
    var priority:Int = 0
    var parentShape:CAShapeLayer?
    var zLocation:Int = 0
    
    init(model:SVGDataModel) {
        self.model = model
        self.isOnePath = (self.model.childs.findPaths().count == 1)
    }
    
    func nodeInfo() -> String {
        return model.name
    }
    
    static func == (lhs: MacosxCodeNode, rhs: MacosxCodeNode) -> Bool {
        return lhs.model == rhs.model
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

final class MacosxCode {
    static let shared = MacosxCode()
    var height:Double = 0
    var layerTable:[String:CAShapeLayer] = [:]
    
    func makeRect(_ rect:CGRect) -> NSBezierPath {
        return NSBezierPath(rect: rect)
    }
    
    func makePath(_ svgPath: SVGPath) -> NSBezierPath {
        let path = NSBezierPath()
        for command in svgPath.commands {
            switch command.type {
            case .move:
                path.move(to: NSPoint(x: command.point.x, y: command.point.y).toBottom(height: height))
                break
            case .line:
                path.line(to: NSPoint(x: command.point.x, y: command.point.y).toBottom(height: height))
                break
            case .quadCurve:
                path.addQuadCurve(to: command.point.toBottom(height: height), controlPoint: command.control1.toBottom(height: height))
                break
            case .cubeCurve:
                path.curve(to: NSPoint(x: command.point.x, y: command.point.y).toBottom(height: height), controlPoint1: NSPoint(x: command.control1.x, y: command.control1.y).toBottom(height: height), controlPoint2: NSPoint(x: command.control2.x, y: command.control2.y).toBottom(height: height))
                break
            case .close:
                path.close()
                break
            case .style:
                break
            }
        }
        return path
    }
    
    func makeGrapth(_ model: SVGDataModel) -> CAShapeLayer {
        let shape = CAShapeLayer()
        if let namelayer = model.layerName {
            shape.name = namelayer
        }
        else {
            shape.name = model.name
        }
        
        return shape
    }
    
    func makeSVG(_ model:SVGDataModel)->CAShapeLayer {
        let shape = CAShapeLayer()
        shape.frame = model.frame.toBottom(height: height)
        shape.name = model.name
        return shape
    }
    
    func makeCircle( _ center:CGPoint, _ radius:Double) -> NSBezierPath {
        return NSBezierPath(circle: center.toBottom(height: height), radius: CGFloat(radius))
    }
    
    func makeClipPath(_ model:SVGDataModel, childs:[NSBezierPath]) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.identify = model.id
        
        if childs.count > 0 {
            if childs.count == 1 {
                let ele = childs[0] as NSBezierPath
                shape.path = ele.cgPath
            }
            else {
                let mutablePath = CGMutablePath()
                for ele in childs {
                    mutablePath.addPath(ele.cgPath)
                }
                shape.path = mutablePath
            }
        }
        return shape
    }
    
    func makeDefs(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeEllipse(_ center:CGPoint, _ radius1:Double, _ radius2:Double) -> NSBezierPath {
        return NSBezierPath(ellipse: center.toBottom(height: height), rx: CGFloat(radius1), ry: CGFloat(radius2))
    }
    
    func makeGlyph(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeLine(_ point1:CGPoint, _ point2:CGPoint) -> NSBezierPath {
        return NSBezierPath(line: point1.point.toBottom(height: height), point2: point2.point.toBottom(height: height))
    }
    
    func makePolyline(_ points:[CGPoint]) -> NSBezierPath {
        let path = NSBezierPath()
        if points.count >= 3 {
            path.move(to: points[0].point.toBottom(height: height))
            for i in 1...points.count-1 {
                path.line(to: points[i].point.toBottom(height: height))
            }
            path.close()
        }
        return path
    }
    
    func makeRadialGradient(_ model:SVGDataModel, _ colors:[String], _ locations:[NSNumber], _ point:CGPoint, _ radius:Double) -> CAShapeLayer {
        let newcolor = colors.map { (ele) -> CGColor in
            return ele.colorValue.cgColor
        }
        
        let newlocation = locations.map { (ele) -> NSNumber in
            return NSNumber(value: ele.doubleValue)
        }
        
        let mask = CAShapeLayer()
        mask.path = NSBezierPath.init(circle: point.point.toBottom(height: height), radius: CGFloat(radius)).cgPath
        mask.strokeColor = NSColor.clear.cgColor
        mask.fillColor  = NSColor.clear.cgColor
        
        let shape = CAGradientLayer()
        shape.startPoint = CGPoint(x: 0.0, y: 0.0).toBottom(height: height)
        shape.endPoint = CGPoint(x: 1.0, y: 1.0).toBottom(height: height)
        shape.mask = mask
        shape.colors = newcolor
        shape.locations = newlocation
        shape.name = model.name
        
        let layer = CAShapeLayer()
        layer.name = model.name
        layer.addSublayer(shape)
        return layer
    }
    
    func makePolygon(_ model:SVGDataModel, _ points:[CGPoint])->NSBezierPath {
        let path = NSBezierPath()
        if points.count >= 3 {
            path.move(to: points[0].point.toBottom(height: height))
            for i in 1...points.count-1 {
                path.line(to: points[i].point.toBottom(height: height))
            }
            path.close()
        }
        return path
    }
    
    
    //MARK:--
    //MARK: Map Model to Shape
    func map(toPath model:SVGDataModel) -> CGPath? {
        let type = model.type
        var path:CGPath? = nil
        switch type {
        case .rect:
            let x = model.element.attributes["x"] ?? "0"
            let y = model.element.attributes["y"] ?? "0"
            
            if let width = model.element.attributes["width"], let height = model.element.attributes["height"]{
                let rect = CGRect(x: x.doubleValue, y: y.doubleValue, width: width.doubleValue, height: height.doubleValue)
                path = makeRect(rect).cgPath
            }
            break
        case .path:
            if let text = model.element.attributes["d"] {
                path = makePath(SVGPath(text)).cgPath
            }
            break
        case .ellipse:
            let x = model.element.attributes["cx"] ?? "0"
            let y = model.element.attributes["cy"] ?? "0"
            let rx = model.element.attributes["rx"] ?? "0"
            let ry = model.element.attributes["ry"] ?? "0"
            let point = CGPoint.init(x: x.doubleValue, y: y.doubleValue)
            path = makeEllipse(point, rx.doubleValue, ry.doubleValue).cgPath
            break
        case .line:
            let x1 = model.element.attributes["x1"] ?? "0"
            let y1 = model.element.attributes["y1"] ?? "0"
            let x2 = model.element.attributes["x2"] ?? "0"
            let y2 = model.element.attributes["y2"] ?? "0"
            let p1 = CGPoint(x: x1.doubleValue, y: y1.doubleValue)
            let p2 = CGPoint(x: x2.doubleValue, y: y2.doubleValue)
            path = makeLine(p1, p2).cgPath
            break
        case .polyline:
            if let points = model.element.attributes["points"]{
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
                    path = makePolyline(ps).cgPath
                }
            }
            break
        case .polygon:
            if let points = model.element.attributes["points"]{
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
                    path = makePolygon(model, ps).cgPath
                }
            }
            break
        case .circle:
            let x = model.element.attributes["cx"] ?? "0"
            let y = model.element.attributes["cy"] ?? "0"
            let point = CGPoint(x: x.doubleValue, y: y.doubleValue)
            if let radius = model.element.attributes["r"] {
                path = makeCircle(point, radius.doubleValue).cgPath
            }
            break
        default:
            break
        }
        return path
    }
    
    func map(toShape model:SVGDataModel) -> CAShapeLayer? {
        let type = model.type
        var shape:CAShapeLayer? = nil
        switch type {
        case .g:
            shape = makeGrapth(model)
            break
        case .svg:
            
            shape = makeSVG(model)
            break
        case .glyph:
            break
        case .radialGradient:
            let x = model.element.attributes["cx"] ?? "0"
            let y = model.element.attributes["cy"] ?? "0"
            let radius = model.element.attributes["r"] ?? "0"
            var colors = [String]()
            var locations = [NSNumber]()
            let point = CGPoint(x: x.doubleValue, y: y.doubleValue)
            for ele in model.element.childElements {
                let offset = ele.attributes["offset"] ?? "0"
                let style = ele.attributes["style"] ?? ""
                let color = style.split(separator: ":")
                if(color.count >= 2) {
                    colors.append(String(color[1]))
                }
                locations.append(NSNumber(value: offset.doubleValue))
            }
            shape = makeRadialGradient(model, colors, locations, point, radius.doubleValue)
            break
        default:
            break
        }
        return shape
    }
    
    func parseModel(_ model:SVGDataModel, _ style:StyleSheet, _ deep:Int) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.contentsGravity = .topLeft
        layer.name = model.name
        print("scan deep \(deep)")
        layer.zPosition = CGFloat(deep)
        
        let childPaths = model.childs.findPaths()
        var isOnePath = false
        if childPaths.count == 1 {
            isOnePath = true
        }
         
        for child in model.childs {
            if child.isPath {
                if isOnePath == false {
                    let shape = CAShapeLayer()
                    let name = "\(model.type.rawValue)\(child.name.trim(child.type.rawValue))"
                    shape.name = name
                    shape.path = map(toPath: child)
                    shape.applyShapeStyle(child, style)
                    layer.addSublayer(shape)
                }
                else {
                    layer.path = map(toPath: child)
                    layer.applyShapeStyle(child, style)
                }
                
            }
            else if child.isShape {
                let childShape = self.parseModel(child, style, deep+1)
                childShape.applyShapeStyle(child, style)
                layer.addSublayer(childShape)
            }
        }
        return layer
    }
    
    func breadthFirstTraverse(model:SVGDataModel, style:StyleSheet){
        let queueObj = Queue<MacosxCodeNode>()
        let node = Node<MacosxCodeNode>.init(data: MacosxCodeNode.init(model: model))
        var index = 0
        var deep = 0
        node.data.index = index
        node.data.deep = deep
        _ = queueObj.enQueue(node: node)
        while !queueObj.isEmpty {
            let objFront = queueObj.queueFront()
            _ = queueObj.deQueue()
            doSomething(index: objFront!.data.index, deep: objFront!.data.deep, size: queueObj.getSize())
            if let child = objFront?.data.model.childs {
                deep = deep + 1
                for item in child {
                    let newNode = Node<MacosxCodeNode>.init(data: MacosxCodeNode.init(model: item))
                    newNode.data.deep = deep
                    newNode.data.index = index
                    _ = queueObj.enQueue(node: newNode)
                    index = index + 1
                }
            }
            deep = 0
        }
        
    }
    
    func doSomething(index:Int, deep:Int, size:Int){
        print("scan item with index \(index) with deep \(deep) with size \(size) byte")
    }
}
