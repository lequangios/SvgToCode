//
//  ObjCode.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

final class ObjCode : CodeMaker {

    static let shared = ObjCode()
    
    internal func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel = SVGDataModel())->String{
        let code = "UIBezierPath* \(name) = [UIBezierPath bezierPathWithRect:CGRectMake(\(rect.origin.x), \(rect.origin.y), \(rect.size.width), \(rect.size.height))];\n"
        return code
    }
    
    internal func makePath(_ svgPath: SVGPath, _ name:String, _ model:SVGDataModel = SVGDataModel()) -> String {
        var code:String = "UIBezierPath* \(name) = [UIBezierPath new];\n";
        for command in svgPath.commands {
            switch command.type {
            case .move:
                code += "[\(name) moveToPoint: CGPointMake(\(command.point.x.str), \(command.point.y.str))];\n"
                break
            case .line:
                code += "[\(name) addLineToPoint:CGPointMake(\(command.point.x.str), \(command.point.y.str))];\n"
                break
            case .quadCurve:
                code += "[\(name) addQuadCurveToPoint:CGPointMake(\(command.point.x.str), \(command.point.y.str)) controlPoint:CGPointMake(\(command.control1.x.str), \(command.control1.y.str))];\n"
                break
            case .cubeCurve:
                code += "[\(name) addCurveToPoint:CGPointMake(\(command.point.x.str), \(command.point.y.str)) controlPoint1:CGPointMake(\(command.control1.x.str), \(command.control1.y.str)) controlPoint2:CGPointMake(\(command.control2.x.str), \(command.control2.y.str))];\n"
                break
            case .close:
                code += "[\(name) closePath];\n"
                break
            case .style:
                code += "[\(name) fill];\n"
            }
        }
        return code
    }
    
    func makeCircle(_ model: SVGDataModel, _ center:CGPoint, _ radius:Double) -> String {
        var code = "UIBezierPath* \(model.name) = [UIBezierPath new];\n"
        code += "[\(model.name) addArcWithCenter:CGPointMake(\(center.x), \(center.y)) radius:\(radius) startAngle:0 endAngle:2*M_PI clockwise:YES];\n"
        return code
    }
    
    func makeClipPath(_ model:SVGDataModel, childs:[CodeGroup]) -> String {
        return ""
    }
    
    func makeDefs(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeEllipse(_ model: SVGDataModel, _ center:CGPoint, _ radius1:Double, _ radius2:Double) -> String {
        return "UIBezierPath* \(model.name) = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(\(center.x - radius1), \(center.y - radius2), \(radius1), \(radius2))];\n"
    }
    
    func makeGlyph(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeLine(_ model: SVGDataModel, _ point1:CGPoint, _ point2:CGPoint) -> String {
        var code = "UIBezierPath* \(model.name) = [UIBezierPath new];\n"
        code += "[\(model.name) moveToPoint:CGPointMake(\(point1.x), \(point1.y)];\n"
        code += "[\(model.name) addLineToPoint:CGPointMake(\(point2.x), \(point2.y))];\n"
        return code
    }
    
    func makePolyline(_ model:SVGDataModel, _ points:[CGPoint]) -> String {
        if points.count >= 3 {
            var code:String = "UIBezierPath* \(model.name) = [UIBezierPath new];\n"
            code += "[\(model.name) moveToPoint:CGPointMake(\(points[0].x), \(points[0].y)];\n"
            for i in 1...points.count-1 {
                code += "[\(model.name) addLineToPoint:CGPointMake(\(points[i].x), \(points[i].y))];\n"
            }
            code += "[\(model.name) closePath];\n"
            return code
        }
        return ""
    }
    
    func makeRadialGradient(_ model:SVGDataModel, _ colors:[String], _ locations:[NSNumber], _ point:CGPoint, _ radius:Double) -> String {
        return ""
    }
    
    func makePolygon(_ model:SVGDataModel, _ points:[CGPoint])->String {
        if points.count >= 3 {
            var code:String = "UIBezierPath* \(model.name) = [UIBezierPath new];\n"
            code += "[\(model.name) moveToPoint:CGPointMake(\(points[0].x), \(points[0].y)];\n"
            for i in 1...points.count-1 {
                code += "[\(model.name) addLineToPoint:CGPointMake(\(points[i].x), \(points[i].y))];\n"
            }
            code += "[\(model.name) closePath];\n"
            return code
        }
        return ""
    }
    
    func makeGrapth(_ name: String, _ model: SVGDataModel) -> String {
        var code = "\nCAShapeLayer*  \(model.name) =  [CAShapeLayer new];\n"
        if let namelayer = model.layerName {
            code += "\(model.name).name = \(namelayer.objStr());\n"
        }
        else {
            code += "\(model.name).name = \(model.name.objStr())\n"
        }
        
        return code
    }
    
    func parseModel(_ model:SVGDataModel, _ style:StyleSheet, _ deep:Int = 0) -> String {
        model.printModel("\(deep)")
        var code = model.code
        let childPaths = model.childs.findPaths()
        var isOnePath = false
        if childPaths.count == 1 {
            isOnePath = true
        }
        
        for child in model.childs {
            if child.isPath {
                code += child.code
            
                if isOnePath == false {
                    let name = "\(model.type.rawValue)\(child.name.trim(child.type.rawValue))"
                    code += "CAShapeLayer* \(name) = [CAShapeLayer new];\n"
                    code += "\(name).path = \(child.name).cgPath;\n"
                    child.name = name
                    code += applyShapeStyle(child, style, child.name)
                    code += "[\(model.name) addSublayer(\(child.name)];\n\n"
                }
                else {
                    code += "\(model.name).path = \(child.name).cgPath;\n"
                    code += applyShapeStyle(child, style, model.name)
                }
                
            }
            else if child.isShape {
                code += self.parseModel(child, style, deep+1)
                code += applyShapeStyle(child, style, child.name)
                code += "[\(model.name) addSublayer(\(child.name)];\n\n"
            }
        }
        return code
    }
    
    func makeSVG(_ model:SVGDataModel)->String {
        var code = "\nCAShapeLayer* \(model.name) = [CAShapeLayer new];\n"
        code += "\(model.name).frame = CGRectMake(\(model.frame.origin.x), \(model.frame.origin.y), \(model.frame.size.width), \(model.frame.size.height));\n"
        code += "\(model.name).name = \(model.name.objStr());\n"
        code += "CGSize viewSize = \(model.name).frame.size;\n"
        code += "CGSize screenSize = [UIScreen mainScreen].bounds.size;\n"
        code += "CGAffineTransform affine = CGAffineTransformMakeTranslation((screenSize.width - viewSize.width)/2, (screenSize.height - viewSize.width)/2);\n"
        code += "[\(model.name) setAffineTransform:affine];\n"
        return code
    }
    
    func getCode(_ model:SVGDataModel, _ style:StyleSheet) -> String {
        return parseModel(model, style, 0)
    }
    
    private func applyPathStyle(_ model:SVGDataModel, _ style:StyleSheet) -> String {
        return ""
    }
    
    private func applyShapeStyle(_ model:SVGDataModel, _ style:StyleSheet, _ name:String) -> String {
        return ""
    }
}
