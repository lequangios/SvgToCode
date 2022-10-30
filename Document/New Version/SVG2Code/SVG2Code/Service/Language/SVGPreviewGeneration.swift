//
//  SVGPreviewGeneration.swift
//  SVG2Code
//
//  Created by Le Quang on 5/12/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics

final class SVGPreviewGeneration {
    var layerTable:[String:CAShapeLayer] = [:]
    var height:Double = 0
    
    func map(path model:SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        switch model.type {
        case .rect:
            return makeRect(model: model, tree: tree)
        case .path:
            return makePath(model: model, tree: tree)
        case .circle:
            return makeCircle(model: model, tree: tree)
        case .ellipse:
            return makeEllipse(model: model, tree: tree)
        case .line:
            return makeLine(model: model, tree: tree)
        case .polyline:
            return makePolyline(model: model, tree: tree)
        case .polygon:
            return makePolygon(model: model, tree: tree)
        default:
            return nil
        }
        
    }
    
    func map(shape model:SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        switch model.type {
        case .radialGradient:
            return makeRadialGradient(model: model, tree: tree)
        case .use:
            return makeUse(model: model, tree: tree)
        case .glyph:
            return makeGlyph(model: model, tree: tree)
        case .clipPath:
            return makeClipPath(model: model, tree: tree)
        case .defs:
            return makeDefs(model: model, tree: tree)
        case .g:
            return makeGrapth(model: model, tree: tree)
        default:
            return nil
        }
    }
    
    func map(preview model:SVGNodeModel, tree: SVGTreeModel, shouldMakeShape: Bool, parentShape:inout CALayer, previewModel: inout SVGPreviewModel){
        if model.isPath {
            let path = map(path: model, tree: tree)
            if shouldMakeShape {
                var newshape = CAShapeLayer()
                newshape.path = path?.cgPath
                newshape.name = model.shapeName
                newshape.zPosition = model.zPosition
                applyShapeStyle(model: model, tree: tree, element: &newshape)
                parentShape.addSublayer(newshape)
                previewModel.layerList[model.shapeName] = newshape
            }
            
            if var parent = parentShape as? CAShapeLayer {
                parent.path = path?.cgPath
                applyShapeStyle(model: model, tree: tree, element: &parent)
            }
            else {
                var newshape = CAShapeLayer()
                newshape.path = path?.cgPath
                newshape.name = model.shapeName
                newshape.zPosition = model.zPosition
                applyShapeStyle(model: model, tree: tree, element: &newshape)
                parentShape.addSublayer(newshape)
                previewModel.layerList[model.shapeName] = newshape
            }
            
        }
        else if model.isShape && model.childs.count > 0 {
            var shape = (map(shape: model, tree: tree) ?? CALayer()) as CALayer
            let childInfo = model.isOnlyOneChildPath()
            
            for child in model.childs {
                map(preview: child, tree: tree, shouldMakeShape: childInfo.isMultiPath, parentShape: &shape, previewModel: &previewModel)
            }
            
            parentShape.addSublayer(shape)
            previewModel.layerList[model.name] = shape
        }
    }
}

extension SVGPreviewGeneration : PreviewGenerationProtocol {
    func makeRect(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let data = model.nodeData as? SVGRect {
            return NSBezierPath(rect: data)
        }
        return nil
    }
    
    func makePath(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let data = model.nodeData as? SVGPath {
            let path = NSBezierPath()
            for command in data.commands {
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
                }
            }
            return path
        }
        return nil
    }
    
    func makeCircle(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let data = model.nodeData as? SVGCircle {
            return NSBezierPath(circle: data.center.toBottom(height: height), radius: CGFloat(data.radius))
        }
        return nil
    }
    
    func makeEllipse(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let data = model.nodeData as? SVGEllipse {
            return NSBezierPath(ellipse: data.point.toBottom(height: height), rx: CGFloat(data.rx), ry: CGFloat(data.ry))
        }
        return nil
    }
    
    func makeLine(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let data = model.nodeData as? SVGLine {
            return NSBezierPath(line: data.p1.toBottom(height: height), point2: data.p2.toBottom(height: height))
        }
        return nil
    }
    
    func makePolyline(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let points = model.nodeData as? SVGPolyline {
            if points.count > 3 {
                let path = NSBezierPath()
                path.move(to: points[0].toBottom(height: height))
                for i in 1...points.count-1 {
                    path.line(to: points[i].toBottom(height: height))
                }
                path.close()
                return path
            }
        }
        return nil
    }
    
    func makePolygon(model: SVGNodeModel, tree: SVGTreeModel) -> NSBezierPath? {
        if let points = model.nodeData as? SVGPolyline {
            if points.count > 3 {
                let path = NSBezierPath()
                path.move(to: points[0].toBottom(height: height))
                for i in 1...points.count-1 {
                    path.line(to: points[i].toBottom(height: height))
                }
                path.close()
                return path
            }
        }
        return nil
    }
    
    func makeRadialGradient(model: SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        if let data = model.nodeData as? SVGRadialGradient {
            let newcolor = data.colors.map { (ele) -> CGColor in
                return ele.colorValue.cgColor
            }
            
            let newlocation = data.locations.map { (ele) -> NSNumber in
                return NSNumber(value: ele.doubleValue)
            }
            
            let mask = CAShapeLayer()
            mask.path = NSBezierPath.init(circle: data.point.toBottom(height: height), radius: CGFloat(data.radius)).cgPath
            mask.strokeColor = NSColor.clear.cgColor
            mask.fillColor  = NSColor.clear.cgColor
            
            let shape = CAGradientLayer()
            shape.startPoint = CGPoint(x: 0.0, y: 0.0).toBottom(height: height)
            shape.endPoint = CGPoint(x: 1.0, y: 1.0).toBottom(height: height)
            shape.mask = mask
            shape.colors = newcolor
            shape.locations = newlocation
            
            let layer = CAShapeLayer()
            layer.name = model.name
            layer.zPosition = model.zPosition
            layer.addSublayer(shape)
            return layer
        }
        return nil
    }
    
    func makeText(model: SVGNodeModel, tree: SVGTreeModel) -> CATextLayer? {
        if let data = model.nodeData as? SVGText {
            let layer = CATextLayer()
            layer.string = data.text
            layer.name = model.name
            layer.zPosition = model.zPosition
            return layer
        }
        return nil
    }
    
    func makeUse(model: SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        return nil
    }
    
    func makeGlyph(model: SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        return nil
    }
    
    func makeClipPath(model: SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        return nil
    }
    
    func makeDefs(model: SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        return nil
    }
    
    func makeGrapth(model: SVGNodeModel, tree: SVGTreeModel) -> CAShapeLayer? {
        let shape = CAShapeLayer()
        shape.name = model.name
        shape.zPosition = model.zPosition
        return shape
    }
    
    func makeSVG(model: SVGNodeModel, tree: SVGTreeModel) -> CALayer? {
        if let data = model.nodeData as? SVG {
            height = Double(data.viewbox.height)
            let shape = CAShapeLayer()
            shape.frame = data.viewbox
            shape.name = model.name
            return shape
        }
        return nil
    }
    
    func applyShapeStyle(model: SVGNodeModel, tree: SVGTreeModel, element: inout CAShapeLayer) {
        if tree.style != nil {
            let attribute = model.computingAttribute(tree.style)
            element.applyAttribute(attribute: attribute)
        }
    }
    
    func generatecode(model: SVGNodeModel, tree: SVGTreeModel) -> SVGPreviewModel? {
        if let data = model.nodeData as? SVG {
            var layer:CALayer = makeSVG(model: model, tree: tree) ?? CALayer()
            var preview = SVGPreviewModel(layer: layer, layerList: [:], size: data.viewbox.size)
            map(preview: model, tree: tree, shouldMakeShape: model.isOnlyOneChildPath().isMultiPath, parentShape: &layer, previewModel: &preview)
            preview.layer = layer
            return preview
        }
        return nil
    }
}
