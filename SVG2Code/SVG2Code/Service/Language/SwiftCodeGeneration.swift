//
//  SwiftCodeGeneration.swift
//  SVG2Code
//
//  Created by Le Quang on 5/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

final class SwiftCodeGeneration {
    func map(path model: SVGNodeModel, tree: SVGTreeModel) -> String {
        var code = ""
        switch model.type {
        case .rect:
            code = makeRect(model: model, tree: tree)
            break
        case .path:
            code = makePath(model: model, tree: tree)
            break
        case .circle:
            code = makeCircle(model: model, tree: tree)
            break
        case .ellipse:
            code = makeEllipse(model: model, tree: tree)
            break
        case .line:
            code = makeLine(model: model, tree: tree)
            break
        case .polyline:
            code = makePolyline(model: model, tree: tree)
            break
        case .polygon:
            code = makePolygon(model: model, tree: tree)
            break
        default:
            break
        }
        return code
    }
    
    func map(shape model:SVGNodeModel, tree: SVGTreeModel) -> String {
        var code = ""
        switch model.type {
        case .radialGradient:
            code = makeRadialGradient(model: model, tree: tree)
            break
        case .use:
            code = makeUse(model: model, tree: tree)
            break
        case .glyph:
            code = makeGlyph(model: model, tree: tree)
            break
        case .clipPath:
            code = makeClipPath(model: model, tree: tree)
            break
        case .defs:
            code = makeDefs(model: model, tree: tree)
            break
        case .g:
            code = makeGrapth(model: model, tree: tree)
            break
        case .svg:
            code = makeSVG(model: model, tree: tree)
            break
        default:
            break
        }
        return code
    }
    
    func map(swift model:SVGNodeModel, tree: SVGTreeModel, shouldMakeShape: Bool, parentName:String) -> String {
        if model.isPath {
            var code = map(path: model, tree: tree)
            if shouldMakeShape {
                code += "let \(model.shapeName) = CAShapeLayer()\n"
                code += "\(model.shapeName).path = \(model.name).cgPath\n"
                code += "\(model.shapeName).name = \(model.shapeName.swiftStr)\n"
                code += "\(model.shapeName).zPosition = CGFloat(\(model.zPosition))\n"
                code += applyShapeStyle(model: model, tree: tree, shapename: model.shapeName)
                code += "\(parentName).addSublayer(\(model.shapeName))\n"
                code += "\n"
            }
            else {
                code += "\(parentName).path = \(model.name).cgPath\n"
                code += applyShapeStyle(model: model, tree: tree, shapename: parentName)
                code += "\n"
            }
            return code
        }
        else if model.isShape && model.childs.count > 0 {
            var code = map(shape: model, tree: tree)
            let childInfo = model.isOnlyOneChildPath()
            
            for child in model.childs {
                code += map(swift: child, tree: tree, shouldMakeShape: childInfo.isMultiPath, parentName: model.name)
            }
            
            // Mean this shape is not root shape
            if parentName != "" {
                code += "\(parentName).addSublayer(\(model.name))\n"
                code += "\n"
            }
            
            return code
        }
        
        return ""
    }
}

extension SwiftCodeGeneration : CodeGenerationProtocol {
    
    func name() -> String {
        return "swift"
    }
    
    func makeRect(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGRect {
            let code = "let \(model.name) = UIBezierPath(rect: CGRect(x: \(data.origin.x), y: \(data.origin.y), width: \(data.size.width), height: \(data.size.height)))\n"
            return code
        }
        return ""
    }
    
    func makePath(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGPath {
            var code:String = "let \(model.name) = UIBezierPath()\n"
            for command in data.commands {
                switch command.type {
                case .move:
                    code += "\(model.name).move(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                    break
                case .line:
                    code += "\(model.name).addLine(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                    break
                case .quadCurve:
                    code += "\(model.name).addQuadCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)))\n"
                    break
                case .cubeCurve:
                    code += "\(model.name).addCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint1: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)), controlPoint2: CGPoint(x: \(command.control2.x.str), y: \(command.control2.y.str)))\n"
                    break
                case .close:
                    code += "\(model.name).close()\n"
                    break
                case .style:
                    code += "\(model.name).fill(\"\(command.nameStyle)\")\n"
                }
            }
            return code
        }
        return ""
    }
    
    func makeCircle(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGCircle {
            let code = "let \(model.name) = UIBezierPath(circle: CGPoint(x: \(data.center.x), y: \(data.center.y)), radius: \(data.radius))\n"
            return code
        }
        return ""
    }
    
    func makeEllipse(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGEllipse {
            return "let \(model.name) = UIBezierPath(ellipse: CGPoint(x: \(data.point.x), y: \(data.point.y)), rx: \(data.rx), ry: \(data.ry))\n"
        }
        return ""
    }
    
    func makeLine(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGLine {
            return "let \(model.name) = UIBezierPath(line: CGPoint(x: \(data.p1.x), y: \(data.p1.y)), point2: CGPoint(x: \(data.p2.x), y: \(data.p2.y)))\n"
        }
        return ""
    }
    
    func makePolyline(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGPolyline {
            if data.count >= 3 {
                var code:String = "let \(model.name) = UIBezierPath()\n"
                code += "\(model.name).move(to: CGPoint(x: \(data[0].x), y: \(data[0].y)))\n"
                for i in 1...data.count-1 {
                    code += "\(model.name).addLine(to: CGPoint(x: \(data[i].x), y: \(data[i].y)))\n"
                }
                code += "\(model.name).close()\n"
                return code
            }
        }
        return ""
    }
    
    func makePolygon(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGPolyline {
            if data.count >= 3 {
                var code:String = "let \(model.name) = UIBezierPath()\n"
                code += "\(model.name).move(to: CGPoint(x: \(data[0].x), y: \(data[0].y)))\n"
                for i in 1...data.count-1 {
                    code += "\(model.name).addLine(to: CGPoint(x: \(data[i].x), y: \(data[i].y)))\n"
                }
                code += "\(model.name).close()\n"
                return code
            }
        }
        return ""
    }
    
    func makeRadialGradient(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGRadialGradient {
            let newcolor = data.colors.map { (ele) -> String in
                return "\(ele.swiftStr).colorValue.cgColor"
            }
            
            let newlocation = data.locations.map { (ele) -> String in
                return "\(ele.doubleValue)"
            }
            
            let maskname = model.maskName
            var code = "let \(maskname) = CAShapeLayer()\n"
            code += "\(maskname).path = UIBezierPath(circle: CGPoint(x: \(data.point.x), y: \(data.point.y)), radius: \(data.radius)).cgPath\n"
            code += "\(maskname).strokeColor = UIColor.clear.cgColor\n"
            code += "\(maskname).fillColor = UIColor.clear.cgColor\n"
            
            code += "let \(model.name) = CAGradientLayer()\n"
            code += "\(model.name).startPoint = CGPoint(x: 0.0, y: 0.0)\n"
            code += "\(model.name).endPoint = CGPoint(x: 1.0, y: 1.0)\n"
            code += "\(model.name).mask = \(maskname)\n"
            code += "\(model.name).colors = [\(newcolor.joined(separator: ","))]\n"
            code += "\(model.name).locations = [\(newlocation.joined(separator: ","))]\n"
            code += "\(model.name).zPosition = \(model.zPosition)\n"
            code += "\(model.name).name = \(model.name.swiftStr)\n"
            return code
        }
        return ""
    }
    
    func makeText(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGText {
            var code = "let \(model.name) = CATextLayer()\n"
            code += "\(model.name).string = \(data.text.swiftStr)\n"
            code += "\(model.name).name = \(model.name.swiftStr)\n"
            code += "\(model.name).zPosition = \(model.zPosition)\n"
            code += "\n"
            return code
        }
        return ""
    }
    
    func makeUse(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVGUse {
            let id = String(data.href.dropFirst(1))
            if id != "" {
                if let reference = tree.findReference(id: id, isDefs: true) {
                    return "\nlet \(model.name) = \(reference.name)\n"
                }
            }
            return ""
        }
        return ""
    }
    
    func makeGlyph(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        return ""
    }
    
    func makeClipPath(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if (model.nodeData as? SVGClipPath) != nil {
            var code = "\nlet \(model.name) = CAShapeLayer()\n"
            code += "\(model.name).name = \(model.name.swiftStr)\n"
            return code
        }
        return ""
    }
    
    func makeDefs(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        return ""
    }
    
    func makeGrapth(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        var code = "\nlet \(model.name) = CAShapeLayer()\n"
        code += "\(model.name).name = \(model.name.swiftStr)\n"
        code += "\(model.name).zPosition = \(model.zPosition)\n"
        return code
    }
    
    func makeSVG(model: SVGNodeModel, tree: SVGTreeModel) -> String {
        if let data = model.nodeData as? SVG {
            var code = "\nlet \(model.name) = CALayer()\n"
            code += "\(model.name).frame = CGRect(x: \(data.viewbox.origin.x), y: \(data.viewbox.origin.y), width: \(data.viewbox.size.width), height: \(data.viewbox.size.height))\n"
            code += "\(model.name).name = \(model.name.swiftStr)\n"
            code += "let viewSize = \(model.name).frame.size\n"
            code += "let affine = CGAffineTransform.init(translationX: (UIScreen.main.bounds.size.width-viewSize.width)/2, y: (UIScreen.main.bounds.size.height-viewSize.height)/2)\n"
            code += "\(model.name).setAffineTransform(affine)\n"
            return code
        }
        return ""
    }
    
    func applyShapeStyle(model: SVGNodeModel, tree:SVGTreeModel, shapename:String) -> String {
        let attribute = model.computingAttribute(tree.style)
        var code = ""
        if let fillColor = attribute.fillColor {
            code += "\(shapename).fill(\(fillColor.swiftHexColor))\n"
        }
        if attribute.fillRule.0 != .nonZero {
            code += "\(shapename).fillRule = CAShapeLayerFillRule.evenOdd\n"
        }
        
        if attribute.lineCap.0 != .butt {
            if attribute.lineCap.0 == .round {
                code += "\(shapename).lineCap = .round\n"
            }
            else if attribute.lineCap.0 == .square {
                code += "\(shapename).lineCap = .square\n"
            }
        }
        
        if attribute.lineDashPhase.0 != 0 {
            code += "\(shapename).lineDashPhase = \(attribute.lineDashPhase.0)\n"
        }
        
        if attribute.lineJoin.0 != .miter {
            if attribute.lineJoin.0 == .bevel {
                code += "\(shapename).lineJoin = .bevel\n"
            }
            else  if attribute.lineJoin.0 == .round {
                code += "\(shapename).lineJoin = .round\n"
            }
        }
        
        if attribute.lineWidth.0 != 1 {
            code += "\(shapename).lineWidth = \(attribute.lineWidth.0)\n"
        }
        
        if attribute.miterLimit.0 != 10 {
            code += "\(shapename).miterLimit = \(attribute.miterLimit.0)\n"
        }
        
        if let strokeColor = attribute.strokeColor {
            code += "\(shapename).strokeColor = \(strokeColor.swiftHexColor).colorValue.cgColor\n"
        }
        
        if attribute.opacity.0 != 1 {
            code += "\(shapename).opacity = Float(\(attribute.opacity.0))\n"
        }
        return code
    }
    
    func generatecode(codemaker:CodeGenerationProtocol, model: SVGNodeModel, tree: SVGTreeModel) -> String {
        return self.map(swift: model, tree: tree, shouldMakeShape: model.isOnlyOneChildPath().isMultiPath, parentName: "")
    }
}
