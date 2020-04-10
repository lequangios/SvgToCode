//
//  SwiftCode.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import SwiftSoup

final class SwiftCode : CodeMaker {
    
    var model = SVGDataModel()
    
    static let shared = SwiftCode()
    
    // <rect x="193.984" y="86.443" transform="matrix(0.999 -0.0448 0.0448 0.999 -3.6844 8.7999)" fill="#69C8C3" width="0.893" height="0.267"/>
    internal func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel = SVGDataModel())->String{
        let code = "let \(name) = UIBezierPath(rect: CGRect(x: \(rect.origin.x), y: \(rect.origin.y), width: \(rect.size.width), height: \(rect.size.height)))\n"
        return code
    }
    
    // <path class="st1" d="M796.1,639.8c0,4.5-4.8,8.2-10.8,8.2H310.4c-6,0-10.8-3.7-10.8-8.2v-3.1c0-4.5,4.8-8.2,10.8-8.2h474.8c6,0,10.8,3.7,10.8,8.2V639.8z"/>
    // <path fill="#FFFFFF" d="M187.336,93.331c-0.655,0.084-1.092,0.87-0.979,1.728l0.721,5.545l1.148-0.165l-0.84-7.111L187.336,93.331z"/>
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
        let code = "let \(name) = CAShapeLayer()\n"
        return code
    }
    
    func parseModel(_ name: String, _ model: SVGDataModel) -> String {
        for item in model.childs {
            
        }
        return ""
    }
}
