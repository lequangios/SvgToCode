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

extension Array where Element == String {
    mutating func addWarning(log text:String) {
        let data = "<t>.\(count)</t><w>\(text)</w>"
        append(data)
    }
    mutating func addError(log text:String) {
        let data = "<t>.\(count)</t><e>\(text)</e>"
        append(data)
    }
    mutating func addInfo(log text:String) {
        let data = "<t>.\(count)</t><i>\(text)</i>"
        append(data)
    }
}

class QySVG {
    var rootNode:QySVGNode?
    var cssStyle:QySVGStyleSheet?
    var referencingNodes:[QySVGNode]?
    var traceLogs:[String] = []
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
    init() {
        
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
        if node.info != "" { self.traceLogs.addInfo(log: node.info) }
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
            traceLogs.addError(log: "Multi element had id are \(id)")
        }
        return items.first
    }
    
    func traverse(operation:(_ node:QySVGNode) -> Void) throws{
        if let node = rootNode {
            let queueObj = Queue<QySVGNode>()
            let errCode = queueObj.enQueue(data: node)
            if errCode == .Success {
                while queueObj.isEmpty == false {
                    let objFront = queueObj.queueFront()
                    _ = queueObj.deQueue()
                    if let obj = objFront {
                        operation(obj.data)
                        if obj.data.isAllowChild == true {
                            for item in obj.data.childs {
                                let errCode = queueObj.enQueue(data: item)
                                if errCode != .Success {
                                    throw errCode.enQueueError(byNode: item)
                                }
                            }
                        }
                    }
                }
            }
            else { throw errCode.enQueueError(byNode: node) }
        }
    }
    
    func computedNodeAttributes() throws {
        let queueObj = Queue<QySVGNode>()
        if let node = rootNode {
            let errCode = queueObj.enQueue(data: node)
            if errCode != .Success { throw errCode.enQueueError(byNode: node) }
            while queueObj.isEmpty == false {
                let objFront = queueObj.queueFront()
                _ = queueObj.deQueue()
                if let obj = objFront {
                    obj.data.computedNodeAttributes(withSheet: self.cssStyle)
                    if obj.data.isAllowChild == true {
                        for item in obj.data.childs {
                            let errCode = queueObj.enQueue(data: item)
                            if errCode != .Success { throw errCode.enQueueError(byNode: item)}
                        }
                    }
                }
            }
        }
    }
    
    deinit {
        print("☠️ deinit QySVG")
        self.listNodes.removeAll()
        self.traceLogs.removeAll()
        self.referencingNodes?.removeAll()
        self.rootNode = nil
        self.currentNode = nil
    }
}

extension QySVG {
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
                    if obj.data.childs.count > 0 { svg.traceLogs.addError(log: "\(obj.data.name) not allow has child element.") }
                }
                svg.update(withNode: obj.data)
            }
        }
        return svg
    }
    
    class func test() {
        do {
            let svgContent = NSString.getTemplate(filename: "winter.svg")
            let xml = try XML.parse(svgContent)
            if let svg = xml["svg"].element {
                let ele = try QySVG.buildTree(withXMLElement: svg)
                print(ele.memorySize)
                print(ele.traceLogs.joined())
            }
        }
        catch let e {
            print(e.failureReason)
        }
    }
}
