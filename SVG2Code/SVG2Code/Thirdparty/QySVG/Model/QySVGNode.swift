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
        computedNodeAttributes(withElement: element)
        update(info: "\(tag.rawValue) not implement now")
    }
    func isAcceptableChildNode(withTag tag:QySVGTag) -> Bool { return self.tag.had(category: .kContainerElements) }
    func addChild(withNode node:QySVGNode) {
        if isAcceptableChildNode(withTag: node.tag) {
            childs.append(node)
        }
    }
    // inline > css > inherit > initial
    func computedNodeAttributes(withSheet sheet:QySVGStyleSheet?) {
        computedNodeCSSAttributes(withSheet: sheet)
        if let parentsAttributes = parentNode?.attribute {
            self.attribute.merge(withParentAttibutes: parentsAttributes)
        }
        var attr:[String:QySVGAttribute] = [:]
        for (_, data) in self.attribute.enumerated() {
            if data.value.value != nil { attr[data.key] = data.value }
        }
        self.attribute = attr
    }
    //MARK: Should overide it
    func update(info text:String){ self.info = text }
    private func initAttributte() {
        for item in QySVGAttributeNameCategory.presentationAttributes {
            self.attribute[item.rawValue] = QySVGAttribute(attributeName: item)
        }
    }
    // Get element attribute
    private func computedNodeAttributes(withElement element:XML.Element) {
        for item in QySVGAttributeNameCategory.presentationAttributes {
            if let value = element.attributes[item.rawValue], let attribute = self.attribute[item.rawValue] {
                attribute.setAttributeValue(value: value, priority: .inline)
            }
        }
    }
    private func computedNodeCSSAttributes(withSheet sheet:QySVGStyleSheet?) {
        if let styleSheet = sheet, let select = selector {
            self.attribute.computedStyleValue(withSheet: styleSheet, selector: select, deep: deep)
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
