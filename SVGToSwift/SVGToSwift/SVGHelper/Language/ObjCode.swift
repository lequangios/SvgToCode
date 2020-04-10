//
//  ObjCode.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftSoup

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
    
    func makeGrapth(_ name: String, _ model: SVGDataModel) -> String {
        let code = "CAShapeLayer* \(name) = [CAShapeLayer new];\n"
        return code
    }
}
