//
//  SwiftCode.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

final class SwiftCode : CodeMaker {
    
    
    static let shared = SwiftCode()
    
    internal func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel = SVGDataModel())->String{
        let code = "let \(name) = UIBezierPath(rect: CGRect(x: \(rect.origin.x), y: \(rect.origin.y), width: \(rect.size.width), height: \(rect.size.height)))\n"
        return code
    }
    
    internal func makePath(_ svgPath: SVGPath, _ name:String, _ model:SVGDataModel = SVGDataModel()) -> String {
        var code:String = "let \(name) = UIBezierPath()\n";
        for command in svgPath.commands {
            switch command.type {
            case .move:
                code += "\(name).move(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                break
            case .line:
                code += "\(name).addLine(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                break
            case .quadCurve:
                code += "\(name).addQuadCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)))\n"
                break
            case .cubeCurve:
                code += "\(name).addCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint1: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)), controlPoint2: CGPoint(x: \(command.control2.x.str), y: \(command.control2.y.str)))\n"
                break
            case .close:
                code += "\(name).close()\n"
                break
            case .style:
                code += "\(name).fill(\"\(command.nameStyle)\")\n"
            }
        }
        return code
    }
    
    func makeGrapth(_ name: String, _ model: SVGDataModel) -> String {
        var code = "// 👉 Make shape \n"
        code += "let \(model.name) = CAShapeLayer()\n"
        code += "\(model.name).frame = CGRect(x: \(model.frame.origin.x), y: \(model.frame.origin.y), width: \(model.frame.size.width), height: \(model.frame.size.height))\n"
        code += "\(model.name).name = \(model.name.swiftStr())\n"
        return code
    }
    
    func makeSVG(_ model:SVGDataModel)->String {
        var code = "let \(model.name) = CAShapeLayer()\n"
        code += "\(model.name).frame = CGRect(x: \(model.frame.origin.x), y: \(model.frame.origin.y), width: \(model.frame.size.width), height: \(model.frame.size.height))\n"
        code += "\(model.name).name = \(model.name.swiftStr())\n"
        return code
    }
    
    func makeCircle(_ model: SVGDataModel, _ center:CGPoint, _ radius:Double) -> String {
        let code = "let \(model.name) = UIBezierPath(circle: CGPoint(x: \(center.x), y: \(center.y)), radius: \(radius))\n"
        return code
    }
    
    func makeClipPath(_ model:SVGDataModel, childs:[CodeGroup]) -> String {
        var code = "let \(model.name) = CAShapeLayer()\n"
        if childs.count > 0 {
            if childs.count == 1 {
                let ele = childs[0] as CodeGroup
                code += ele.code
                code += "\(model.name).path = \(ele.name).cgPath\n\n"
            }
            else {
                code += "let \(model.name)_path = CGMutablePath()\n"
                for ele in childs {
                    code += ele.code
                    code += "\(model.name)_path.addPath(\(ele.name).cgPath)\n"
                }
                code += "\(model.name).path = \(model.name).cgPath\n\n"
            }
        }
        return code
    }
    
    func makeDefs(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeEllipse(_ model: SVGDataModel, _ center:CGPoint, _ radius1:Double, _ radius2:Double) -> String {
        return "let \(model.name) = UIBezierPath(ellipse: CGPoint(x: \(center.x), y: \(center.y)), rx: \(radius1), ry: \(radius2))\n"
    }
    
    func makeGlyph(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeLine(_ model: SVGDataModel, _ point1:CGPoint, _ point2:CGPoint) -> String {
        return "let \(model.name) = UIBezierPath(line: CGPoint(x: \(point1.x), y: \(point1.y)), point2: CGPoint(x: \(point2.x), y: \(point2.y)))\n"
    }
    
    func makePolyline(_ model:SVGDataModel, _ points:[CGPoint]) -> String {
        if points.count >= 3 {
            var code:String = "let \(model.name) = UIBezierPath()\n"
            code += "\(model.name).move(to: CGPoint(x: \(points[0].x), y: \(points[0].y)))\n"
            for i in 1...points.count-1 {
                code += "\(model.name).addLine(to: CGPoint(x: \(points[i].x), y: \(points[i].y)))\n"
            }
            code += "\(model.name).close()\n"
            return code
        }
        return ""
    }
    
    func makeRadialGradient(_ model:SVGDataModel, _ colors:[String], _ locations:[NSNumber], _ point:CGPoint, _ radius:Double) -> String {
        return ""
    }
    
    func makePolygon(_ model:SVGDataModel, _ points:[CGPoint])->String {
        if points.count >= 3 {
            var code:String = "let \(model.name) = UIBezierPath()\n";
            code += "\(model.name).move(to: CGPoint(x: \(points[0].x), y: \(points[0].y)))\n"
            for i in 1...points.count-1 {
                code += "\(model.name).addLine(to: CGPoint(x: \(points[i].x), y: \(points[i].y)))\n"
            }
            code += "\(model.name).close()\n"
            return code
        }
        return ""
    }
    
    func parseModel(_ model:SVGDataModel, _ style:StyleSheet, _ deep:Int) -> String {
        model.printModel("\(deep)")
        var code = model.code
        let childPaths = model.childs.findPaths()
        if(childPaths.count > 0) {
            if childPaths.count >= 2 {
                code += "let \(model.name)_path = CGMutablePath()\n"
                code += "\n\n"
                for item in childPaths {
                    if(item.code != ""){
                        code += item.code
                        code += applyPathStyle(item, style)
                        code += "\(model.name)_path.addPath(\(item.name).cgPath)\n"
                    }
                }
                code += "\(model.name).path = \(model.name)_path\n\n"
            }
            else {
                code += childPaths.first!.code
                code += applyPathStyle(childPaths.first!, style)
                code += "\(model.name).path = \(childPaths.first!.name).cgPath\n\n"
            }
        }
        
        let childShapes = model.childs.findShape()
        if(childShapes.count > 0){
            for item in childShapes {
                code += self.parseModel(item, style, deep+1)
                code += applyShapeStyle(item, style)
                code += "\(model.name).addSublayer(\(item.name))\n"
            }
        }
        
        return code
    }
    
    //MARK:--
    //MARK: Apply Style to Draw
    private func applyStyle(_ model:SVGDataModel, _ style:StyleSheet) -> String {
        var code = ""
        if model.isShape() {
            code += applyShapeStyle(model, style)
        }
        else {
            code += applyPathStyle(model, style)
        }
        return code
    }
    
    private func applyPathStyle(_ model:SVGDataModel, _ style:StyleSheet) -> String {
        var code = ""
        let pathAttribute = model.getPathAttributeModel(style)
        
        if pathAttribute.lineWidth != 1.0 {
            code += "\(model.name).lineWidth = \(pathAttribute.lineWidth)\n"
        }
        
        if pathAttribute.lineCapStyle != .butt {
            if pathAttribute.lineCapStyle == .round {
                code += "\(model.name).lineCapStyle = .round\n"
            }
            else if pathAttribute.lineCapStyle == .square {
                code += "\(model.name).lineCapStyle = .square\n"
            }
        }
        
        if pathAttribute.lineJoinStyle != .miter {
            if pathAttribute.lineJoinStyle == .bevel {
                code += "\(model.name).lineJoinStyle = .bevel\n"
            }
            else if pathAttribute.lineJoinStyle == .round {
                code += "\(model.name).lineJoinStyle = .round\n"
            }
        }
        
        if pathAttribute.miterLimit != 10 {
            code += "\(model.name).miterLimit = \(pathAttribute.miterLimit)\n"
        }
        
        if pathAttribute.flatness != 0.6 {
            code += "\(model.name).flatness = \(pathAttribute.flatness)\n"
        }
        
        if pathAttribute.usesEvenOddFillRule != false {
            code += "\(model.name).usesEvenOddFillRule = true\n"
        }
        
        if let strokeColor = pathAttribute.strokeColor {
            code += "\(model.name).strokeWithHex(\(strokeColor.swiftHex()))\n"
           
        }
        
        if let fillColor = pathAttribute.fillColor {
            code += "\(model.name).fillWithHex(\(fillColor.swiftHex()))\n"
        }
        
        return code
    }
    
    private func applyShapeStyle(_ model:SVGDataModel, _ style:StyleSheet) -> String {
        var code = ""
        let shapeAttribute = model.getShapeAttributeModel(style)
        if let fillColor = shapeAttribute.fillColor {
            code += "\(model.name).fill(\"#\(fillColor)\")\n"
        }
        
        if shapeAttribute.fillRule != .nonZero {
            code += "\(model.name).fillRule = CAShapeLayerFillRule.evenOdd\n"
        }
        
        if shapeAttribute.lineCap != .butt {
            if shapeAttribute.lineCap == .round {
                code += "\(model.name).lineCap = .round\n"
            }
            else if shapeAttribute.lineCap == .square {
                code += "\(model.name).lineCap = .square\n"
            }
        }
        
        if shapeAttribute.lineDashPhase != 0 {
            code += "\(model.name).lineDashPhase = \(shapeAttribute.lineDashPhase)\n"
        }
        
        if shapeAttribute.lineJoin != .miter {
            if shapeAttribute.lineJoin == .bevel {
                code += "\(model.name).lineJoin = .bevel\n"
            }
            else  if shapeAttribute.lineJoin == .round {
                code += "\(model.name).lineJoin = .round\n"
            }
        }
        
        if shapeAttribute.lineWidth != 1 {
            code += "\(model.name).lineWidth = \(shapeAttribute.lineWidth)\n"
        }
        
        if shapeAttribute.miterLimit != 10 {
            code += "\(model.name).miterLimit = \(shapeAttribute.miterLimit)\n"
        }
        
        if let strokeColor = shapeAttribute.strokeColor {
            code += "\(model.name).strokeColor = \"#\(strokeColor)\".colorValue.CGColor\n"
        }
        
        if shapeAttribute.opacity != 1 {
            code += "\(model.name).opacity = Float(\(shapeAttribute.opacity))\n"
        }
        
        return code
    }
}
