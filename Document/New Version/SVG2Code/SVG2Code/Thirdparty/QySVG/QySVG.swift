//
//  QySVG.swift
//  SVG2Code
//
//  Created by Le Quang on 6/17/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

extension ErrorCode {
    func makeError(byElement element:XML.Element) -> Error {
        return NSError(domain: "com.mobilecodelab.qysvg.buildtree", code: self.hashValue, description: "Fail with element \(element.name)", failureReason: "Fail with element \(element.name)") as Error
    }
    
    func enQueueError(byElement element:XML.Element) -> Error {
        return NSError(domain: "com.mobilecodelab.qysvg.buildtree", code: self.hashValue, description: "Fail at element \(element.name)", failureReason: "enQueue fail with element \(element.name)") as Error
    }
    
    func enQueueError(byNode node:QySVGNode) -> Error {
        return NSError(domain: "com.mobilecodelab.qysvg.buildtree", code: self.hashValue, description: "Fail at node \(node.name)", failureReason: "enQueue fail with node \(node.name)") as Error
    }
    
    func deQueueError(byElement element:XML.Element) -> Error {
        return NSError(domain: "com.mobilecodelab.qysvg.buildtree", code: self.hashValue, description: "Fail at element \(element.name)", failureReason: "deQueue fail with element \(element.name)") as Error
    }
    
    func deQueueError(byNode node:QySVGNode) -> Error {
        return NSError(domain: "com.mobilecodelab.qysvg.buildtree", code: self.hashValue, description: "Fail at node \(node.name)", failureReason: "deQueue fail with node \(node.name)") as Error
    }
}

class QySVG : BaseObject {
    struct Information {
        var beautyText:String = ""
        var beautyHtml:String = ""
        var code:[String] = []
        var name:String = ""
    }
    var information:Information = Information()
    var rootNode:QySVGNode?
    var cssStyle:QySVGStyleSheet?
    var referencingNodes:[QySVGNode] = []
    var traceLogs:QySVGLogTag = .bootstrap
    fileprivate(set) var parserStack:QyStack<QySVGNode> = QyStack<QySVGNode>()
    fileprivate(set) var traverseQueue:QyQueue<QySVGNode> = QyQueue<QySVGNode>()
    private(set) var currentNode:QySVGNode?
    private(set) var listNodes:[QySVGNode] = [] {
        didSet {
            let count = listNodes.count
            if count > 0 {
                memorySize = treeSize*count
            }
        }
    }
    private var treeSize:Int = MemoryLayout<SVGTreeModel>.stride
    private(set) var memorySize:Int = 0
    override init() {
        super.init()
    }
    
    init(svgContent:String) throws {
        super.init()
        let parser = QyXMLParser(xmlString: svgContent)
        parser.delegate = self
        do {
            try parser.parseXML()
            printf("done")
        }
        catch let e {
            throw e
        }
    }
    
    func update(withNode node:QySVGNode) {
        if node.tag == .kStyle {
            if let attribute = node.attribute[QySVGAttributeName.kContentStyleType.rawValue]?.values.first as? QySVGStringValue {
                update(withCSSText: attribute.value)
            }
        }
        else {
            self.listNodes.append(node)
        }
        if node.info != "" { self.traceLogs.infoTag(text: node.info) }
    }
    
    func update(withCSSText sheet:String){
        if let css = self.cssStyle {
            css.add(CssString: sheet)
        }
        else {
            self.cssStyle = QySVGStyleSheet(withCssString: sheet)
        }
    }
    
    func findNode(byID id:String) -> QySVGNode? {
        let items = listNodes.filter({$0.id == id})
        if items.count > 1 {
            let text = "Multi element had id are <b>\(id)</b>"
            traceLogs.errorTag(text: text)
        }
        return items.first
    }
    
    func renderSVG() throws -> QySVGCanvas {
        var canvas:QySVGCanvas = QySVGCanvas()
        traverse(operation: { [unowned self](node) in
            let log = node.render(fromSVGTree: self, canvas: &canvas)
            if log != "" { self.traceLogs.warningTag(text: log) }
        })
        return canvas
    }
    
    
    func traverse(operation:(_ node:QySVGNode) -> Void){
        if traverseQueue.isEmpty == false { traverseQueue.empty() }
        traverseQueue = QyQueue<QySVGNode>()
        if let node = rootNode {
            traverseQueue.enQueue(data: node)
            while traverseQueue.isEmpty == false {
                if let traverseNode = traverseQueue.head {
                    traverseQueue.deQueue()
                    operation(traverseNode)
                    if traverseNode.isAllowChild == true {
                        for item in traverseNode.childs {
                            traverseQueue.enQueue(data: item)
                        }
                    }
                }
            }
        }
    }
    
    func computedNodeAttributes(){
        if traverseQueue.isEmpty == false { traverseQueue.empty() }
        traverseQueue = QyQueue<QySVGNode>()
        if let node = rootNode {
            traverseQueue.enQueue(data: node)
            while traverseQueue.isEmpty == false {
                if let traverseNode = traverseQueue.head {
                    traverseQueue.deQueue()
                    traverseNode.computedNodeAttributes(withSheet: self.cssStyle)
                    if traverseNode.isAllowChild == true {
                        for item in traverseNode.childs {
                            traverseQueue.enQueue(data: item)
                        }
                    }
                }
            }
        }
    }
    
    // MARK:- Generate Preview Data
    func generatePreview() -> SVGPreviewModel? {
        return SVGPreviewModel()
    }
    
    deinit {
        print("☠️ deinit QySVG")
        if self.parserStack.count > 0 { self.parserStack.empty() }
        if self.traverseQueue.count > 0 { self.traverseQueue.empty() }
        self.listNodes.removeAll()
        self.traceLogs.tags.removeAll()
        self.referencingNodes.removeAll()
        self.rootNode = nil
        self.currentNode = nil
    }
}

extension QySVG : QyXMLParserProtocol {
    func startParsing(element: QyXMLParser.Element) {
        let node = QySVGNode.node(withTagName: element.tag)
        node.updateNode(withElement: element)
        if element.isRoot {
            self.rootNode = node
            parserStack.push(data: node)
        }
        else {
            if let head = parserStack.head {
                if head.isAllowChild == true {
                    node.parentNode = head
                    head.addChild(withNode: node)
                    parserStack.push(data: node)
                }
                else {
                    let text = "\(element.tag) not allow has child element."
                    self.traceLogs.warningTag(text: text)
                }
            }
        }
    }
    
    func endParsing(element: QyXMLParser.Element) {
        if element.isRoot == true {
            information.beautyText = element.rawData
            information.beautyHtml = element.htmlData
        }
        if let head = parserStack.head {
            if head.tag.rawValue == element.tag {
                if element.text != "" { head.textContent = element.text }
                self.update(withNode: head)
                if head.isRenderableNode == false { self.referencingNodes.append(head) }
                parserStack.pop()
            }
        }
    }
}

extension QySVG {
    class func buildTree() {
        
    }
    
    class func buildTree(withXMLElement element:XML.Element) throws -> QySVG {
        var svg = QySVG(), index = 0, deep = 0
        let queueObj = Queue<QySVGNode>()
        let node = QySVGNode.node(withTagName: element.name)
        node.updateNode(byElement: element, index: index, deep: deep)
        svg.rootNode = node
        svg.currentNode = node
        let errCode = queueObj.enQueue(data: node)
        if errCode != .Success { throw errCode.enQueueError(byElement: element) }
        while queueObj.isEmpty == false {
            let objFront = queueObj.queueFront()
            svg.currentNode = objFront?.data
            _ = queueObj.deQueue()
            if let obj = objFront {
                if obj.data.isAllowChild == true {
                    if let childs = obj.data.element?.childElements {
                        deep = obj.data.deep + 1
                        index = index + 1
                        for item in childs {
                            let newnode = QySVGNode.node(withTagName: item.name)
                            newnode.updateNode(byElement: item, index: index, deep: deep)
                            newnode.parentNode = obj.data
                            obj.data.addChild(withNode: newnode)
                            let errCode = queueObj.enQueue(data: newnode)
                            if errCode != .Success { throw errCode.enQueueError(byElement: item)}
                        }
                    }
                }
                else {
                    if obj.data.childs.count > 0 {
                        let text = "\(obj.data.name) not allow has child element."
                        svg.traceLogs.warningTag(text: text)
                    }
                }
                svg.update(withNode: obj.data)
                if obj.data.isRenderableNode == false { svg.referencingNodes.append(obj.data) }
            }
        }
        return svg
    }
    
    class func test() {
        do {
            let svgContent = NSString.getTemplate(filename: "green.svg")
            let svg = try QySVG.init(svgContent: svgContent)
        }
        catch let e {
            //print(e.failureReason)
        }
    }
}
