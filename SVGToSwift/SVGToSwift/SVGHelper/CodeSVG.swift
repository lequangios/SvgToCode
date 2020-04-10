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
    
    func applyCommandsCodeFrom(_ svgPathString: String, _ name:String) -> String {
        let svgPath = SVGPath(svgPathString)
        var code:String = "";
        switch langName {
        case .Js:
            code = self.applyCommandsJSCodeFrom(svgPath, name)
            break
        case .Obj:
            code = self.applyCommandsObjCodeFrom(svgPath, name)
            break
        case .Swift:
            code = self.applyCommandsSwiftCodeFrom(svgPath, name)
            break
        }
        return code;
    }
    
    private func applyCommandsSwiftCodeFrom(_ svgPath: SVGPath, _ name:String) -> String {
        var code:String = "let \(name) = UIBezierPath()\n";
        for command in svgPath.commands {
            switch command.type {
            case .move:
                //move(to: command.point)
                code += "\(name).move(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                break
            case .line:
                //addLine(to: command.point)
                code += "\(name).addLine(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                break
            case .quadCurve:
                //addQuadCurve(to: command.point, controlPoint: command.control1)
                code += "\(name).addQuadCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)))\n"
                break
            case .cubeCurve:
                //addCurve(to: command.point, controlPoint1: command.control1, controlPoint2: command.control2)
                code += "\(name).addCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint1: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)), controlPoint2: CGPoint(x: \(command.control2.x.str), y: \(command.control2.y.str)))\n"
                break
            case .close:
                //close()
                code += "\(name).close()\n"
                break
            case .style:
                code += "\(name).fill(\"\(command.nameStyle)\")\n"
            }
        }
        return code
    }
    
    private func applyCommandsObjCodeFrom(_ svgPath: SVGPath, _ name:String) -> String {
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
                //close()
                code += "[\(name) closePath];\n"
                break
            case .style:
                code += "[\(name) fill];\n"
            }
        }
        return code
    }
    
    private func applyCommandsJSCodeFrom(_ svgPath: SVGPath, _ name:String) -> String {
        return ""
    }
}
