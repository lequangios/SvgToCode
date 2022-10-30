//
//  CodeGenerationProtocol.swift
//  SVG2Code
//
//  Created by Le Quang on 5/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics

protocol CodeGenerationProtocol {
    func makeRect(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makePath(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeCircle(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeEllipse(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeLine(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makePolyline(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makePolygon(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeRadialGradient(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeText(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeUse(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeGlyph(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeClipPath(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeDefs(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeGrapth(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func makeSVG(model: SVGNodeModel, tree:SVGTreeModel) -> String
    func applyShapeStyle(model: SVGNodeModel, tree:SVGTreeModel, shapename:String) -> String
    func generatecode(codemaker:CodeGenerationProtocol, model: SVGNodeModel, tree: SVGTreeModel) -> String
    func name() -> String
}

protocol PreviewGenerationProtocol {
    func makeRect(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makePath(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makeCircle(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makeEllipse(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makeLine(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makePolyline(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makePolygon(model: SVGNodeModel, tree:SVGTreeModel) -> NSBezierPath?
    func makeRadialGradient(model: SVGNodeModel, tree:SVGTreeModel) -> CAShapeLayer?
    func makeText(model: SVGNodeModel, tree:SVGTreeModel) -> CATextLayer?
    func makeUse(model: SVGNodeModel, tree:SVGTreeModel) -> CAShapeLayer?
    func makeGlyph(model: SVGNodeModel, tree:SVGTreeModel) -> CAShapeLayer?
    func makeClipPath(model: SVGNodeModel, tree:SVGTreeModel) -> CAShapeLayer?
    func makeDefs(model: SVGNodeModel, tree:SVGTreeModel) -> CAShapeLayer?
    func makeGrapth(model: SVGNodeModel, tree:SVGTreeModel) -> CAShapeLayer?
    func makeSVG(model: SVGNodeModel, tree:SVGTreeModel) -> CALayer?
    func applyShapeStyle(model: SVGNodeModel, tree:SVGTreeModel, element: inout CAShapeLayer)
    func generatecode(model: SVGNodeModel, tree: SVGTreeModel) -> SVGPreviewModel?
}
