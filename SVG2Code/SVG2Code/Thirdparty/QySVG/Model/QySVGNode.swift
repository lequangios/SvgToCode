//
//  QySVGNode.swift
//  SVG2Code
//
//  Created by Le Quang on 6/11/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

// MARK: - SVG Base Node
class QySVGNode {
    private(set) var tag:QySVGTag
    private(set) var element:XML.Element?
    private(set) var info:String = ""
    var attribute:[String:QySVGAttribute] = [:]
    var childs:[QySVGNode] = []
    var selector:QySVGCSSElement?
    var textContent:String = ""
    weak var parentNode:QySVGNode?
    var index:Int = 0
    var deep:Int = 0
    var id:String = ""
    var name:String { return "\(tag.rawValue)\(index)" }
    var shapeName:String { return "shape\(index)" }
    var maskName:String { return "mask\(index)" }
    var pathName:String { return "path\(index)" }
    var isAllowChild:Bool {
        return tag.had(category: .kContainerElements) || tag.had(category: .kTextContentElements) || tag.had(category: .kStructuralElements)
    }
    var isRenderableNode:Bool {return tag.had(category: .kRenderableElements)}
    class func node(withTagName tagName:String) -> QySVGNode {
        switch tagName {
        case QySVGTag.kA.rawValue:
            return QySVGAElement()
        case QySVGTag.kCircle.rawValue:
            return QySVGCircleElement()
        case QySVGTag.kClipPath.rawValue:
            return QySVGClipPathElement()
        case QySVGTag.kDefs.rawValue:
            return QySVGDefsElement()
        case QySVGTag.kG.rawValue:
            return QySVGGElement()
        case QySVGTag.kLine.rawValue:
            return QySVGLineElement()
        case QySVGTag.kLinearGradient.rawValue:
            return QySVGLinearGradientElement()
        case QySVGTag.kStyle.rawValue:
            return QySVGStyleElement()
        case QySVGTag.kImage.rawValue:
            return QySVGImageElement()
        case QySVGTag.kMarker.rawValue:
            return QySVGMarkerElement()
        case QySVGTag.kMask.rawValue:
            return QySVGMaskElement()
        case QySVGTag.kPath.rawValue:
            return QySVGPathElement()
        case QySVGTag.kPattern.rawValue:
            return QySVGPatternElement()
        case QySVGTag.kPolygon.rawValue:
            return QySVGPolygonElement()
        case QySVGTag.kPolyline.rawValue:
            return QySVGPolylineElement()
        case QySVGTag.kRadialGradient.rawValue:
            return QySVGRadialGradientElement()
        case QySVGTag.kRect.rawValue:
            return QySVGRectElement()
        case QySVGTag.kScript.rawValue:
            return QySVGScriptElement()
        case QySVGTag.kSvg.rawValue:
            return QySVGSvgElement()
        case QySVGTag.kText.rawValue:
            return QySVGTextElement()
        case QySVGTag.kTextPath.rawValue:
            return QySVGTextPathElement()
        case QySVGTag.kTitle.rawValue:
            return QySVGTitleElement()
        case QySVGTag.kTspan.rawValue:
            return QySVGTspanElement()
        case QySVGTag.kUse.rawValue:
            return QySVGUseElement()
        case QySVGTag.kView.rawValue:
            return QySVGViewElement()
        default:
            return QySVGNode(tag: tagName)
        }
    }
    init(){
        self.tag = .kUnknown
        self.initAttributte()
    }
    init(tag:String) {
        self.tag = QySVGTag.getTag(withRawValue: tag)
        if self.tag.had(category: .kDeprecatedElements) {
            self.info = "\(self.tag.rawValue) is old SVG elements which are deprecated and should not be used"
        }
    }
    init(node:QySVGNode) {
        self.tag = node.tag
        self.attribute = node.attribute
        self.childs = node.childs
        self.index = node.index
        self.deep = node.deep
        self.id = node.id
    }
    func updateNode(byElement element:XML.Element, index: Int, deep: Int){
        self.element = element
        self.deep = deep
        self.index = index
        self.selector = QySVGCSSElement.make(withNode: self)
        if let idValue = element.attributes["id"] { self.id = idValue }
        if let text = element.text { self.textContent = text }
        updateAttributes(withElement: element)
        update(info: "\(tag.rawValue) not implement now")
    }
    func isAcceptableChildNode(withTag tag:QySVGTag) -> Bool { return self.tag.had(category: .kContainerElements) }
    func addChild(withNode node:QySVGNode) {
        if isAcceptableChildNode(withTag: node.tag) {
            childs.append(node)
        }
    }
    func computedNodeAttributes(withSheet sheet:QySVGStyleSheet?){
        if let styleSheet = sheet, let select = selector {
            self.attribute.computedStyleValue(withSheet: styleSheet, selector: select, deep: deep)
        }
        if let parentsAttributes = parentNode?.attribute {
            self.attribute.merge(withAttibutes: parentsAttributes)
        }
    }
    
    //MARK: Should overide it
    func update(info text:String){ self.info = text }
    private func initAttributte() {
        self.attribute[QySVGAttributeName.kClipPath.rawValue] = QySVGAttribute(attributeName: .kClipPath)
        self.attribute[QySVGAttributeName.kClipRule.rawValue] = QySVGAttribute(attributeName: .kClipRule)
        self.attribute[QySVGAttributeName.kColor.rawValue] = QySVGAttribute(attributeName: .kColor)
        self.attribute[QySVGAttributeName.kColorInterpolation.rawValue] = QySVGAttribute(attributeName: .kColorInterpolation)
        self.attribute[QySVGAttributeName.kColorRendering.rawValue] = QySVGAttribute(attributeName: .kColorRendering)
        self.attribute[QySVGAttributeName.kCursor.rawValue] = QySVGAttribute(attributeName: .kCursor)
        self.attribute[QySVGAttributeName.kDisplay.rawValue] = QySVGAttribute(attributeName: .kDisplay)
        self.attribute[QySVGAttributeName.kFill.rawValue] = QySVGAttribute(attributeName: .kFill)
        self.attribute[QySVGAttributeName.kFillOpacity.rawValue] = QySVGAttribute(attributeName: .kFillOpacity)
        self.attribute[QySVGAttributeName.kFillRule.rawValue] = QySVGAttribute(attributeName: .kFillRule)
        self.attribute[QySVGAttributeName.kFilter.rawValue] = QySVGAttribute(attributeName: .kFilter)
        self.attribute[QySVGAttributeName.kMask.rawValue] = QySVGAttribute(attributeName: .kMask)
        self.attribute[QySVGAttributeName.kOpacity.rawValue] = QySVGAttribute(attributeName: .kOpacity)
        self.attribute[QySVGAttributeName.kPointerEvents.rawValue] = QySVGAttribute(attributeName: .kPointerEvents)
        self.attribute[QySVGAttributeName.kShapeRendering.rawValue] = QySVGAttribute(attributeName: .kShapeRendering)
        self.attribute[QySVGAttributeName.kStroke.rawValue] = QySVGAttribute(attributeName: .kStroke)
        self.attribute[QySVGAttributeName.kStrokeDasharray.rawValue] = QySVGAttribute(attributeName: .kStrokeDasharray)
        self.attribute[QySVGAttributeName.kStrokeDashoffset.rawValue] = QySVGAttribute(attributeName: .kStrokeDashoffset)
        self.attribute[QySVGAttributeName.kStrokeLinecap.rawValue] = QySVGAttribute(attributeName: .kStrokeLinecap)
        self.attribute[QySVGAttributeName.kStrokeLinejoin.rawValue] = QySVGAttribute(attributeName: .kStrokeLinejoin)
        self.attribute[QySVGAttributeName.kStrokeMiterlimit.rawValue] = QySVGAttribute(attributeName: .kStrokeMiterlimit)
        self.attribute[QySVGAttributeName.kStrokeOpacity.rawValue] = QySVGAttribute(attributeName: .kStrokeOpacity)
        self.attribute[QySVGAttributeName.kStrokeWidth.rawValue] = QySVGAttribute(attributeName: .kStrokeWidth)
        self.attribute[QySVGAttributeName.kTransform.rawValue] = QySVGAttribute(attributeName: .kTransform)
        self.attribute[QySVGAttributeName.kVectorEffect.rawValue] = QySVGAttribute(attributeName: .kVectorEffect)
        self.attribute[QySVGAttributeName.kVisibility.rawValue] = QySVGAttribute(attributeName: .kVisibility)
    }
    private func updateAttributes(withElement element:XML.Element){
        if let value = element.attributes[QySVGAttributeName.kClipPath.rawValue], let attribute = self.attribute[QySVGAttributeName.kClipPath.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kClipRule.rawValue], let attribute = self.attribute[QySVGAttributeName.kClipRule.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kColor.rawValue], let attribute = self.attribute[QySVGAttributeName.kColor.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kColorInterpolation.rawValue], let attribute = self.attribute[QySVGAttributeName.kColorInterpolation.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kColorRendering.rawValue], let attribute = self.attribute[QySVGAttributeName.kColorRendering.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kCursor.rawValue], let attribute = self.attribute[QySVGAttributeName.kCursor.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kDisplay.rawValue], let attribute = self.attribute[QySVGAttributeName.kDisplay.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kFill.rawValue], let attribute = self.attribute[QySVGAttributeName.kFill.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kFillOpacity.rawValue], let attribute = self.attribute[QySVGAttributeName.kFillOpacity.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kFillRule.rawValue], let attribute = self.attribute[QySVGAttributeName.kFillRule.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kFilter.rawValue], let attribute = self.attribute[QySVGAttributeName.kFilter.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kMask.rawValue], let attribute = self.attribute[QySVGAttributeName.kMask.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kOpacity.rawValue], let attribute = self.attribute[QySVGAttributeName.kOpacity.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kPointerEvents.rawValue], let attribute = self.attribute[QySVGAttributeName.kPointerEvents.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kShapeRendering.rawValue], let attribute = self.attribute[QySVGAttributeName.kShapeRendering.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStroke.rawValue], let attribute = self.attribute[QySVGAttributeName.kStroke.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeDasharray.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeDasharray.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeDashoffset.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeDashoffset.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeLinecap.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeLinecap.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeLinejoin.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeLinejoin.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeMiterlimit.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeMiterlimit.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeOpacity.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeOpacity.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kStrokeWidth.rawValue], let attribute = self.attribute[QySVGAttributeName.kStrokeWidth.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kTransform.rawValue], let attribute = self.attribute[QySVGAttributeName.kTransform.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kVectorEffect.rawValue], let attribute = self.attribute[QySVGAttributeName.kVectorEffect.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
        if let value = element.attributes[QySVGAttributeName.kVisibility.rawValue], let attribute = self.attribute[QySVGAttributeName.kVisibility.rawValue] {
            attribute.addAttributeValue(value: value, priority: .inline)
        }
    }
    deinit {
        print("☠️ deinit \(name)")
        attribute.removeAll()
        childs.removeAll()
    }
}

extension QySVGNode : NodeProtocol {
    func nodeInfo() -> String {
        return name
    }
    
    static func == (lhs: QySVGNode, rhs: QySVGNode) -> Bool {
        return lhs.index == rhs.index
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return QySVGNode(node: self)
    }
}

// MARK: - SVG CSS Node
class QyCSSNode : QySVGNode {
    
}

// MARK: - SVG Referencing Node
class QyGraphicsReferencingNode : QySVGNode {
    
}
