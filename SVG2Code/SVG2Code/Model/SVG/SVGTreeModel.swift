//
//  SVGTreeModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser

class SVGTreeModelNode : NodeProtocol {
    private var model:SVGNodeModel
    var element:XML.Element
    var index:Int = 0
    var deep:Int = 0
    var svgModelObj:SVGNodeModel { return model }
    
    init(model:SVGTreeModelNode) {
        self.element = model.element
        self.index = model.index
        self.deep = model.deep
        self.model = SVGNodeModel(index: self.index, deep: self.deep)
    }
    
    init(svgModel:SVGNodeModel) {
        self.index = svgModel.index
        self.deep = svgModel.deep
        self.model = svgModel
        self.element = XML.Element(name: "")
    }
    
    init(element:XML.Element, index:Int, deep:Int) {
        self.index = index
        self.deep = deep
        self.element = element
        self.model = SVGNodeModel(index: self.index, deep: self.deep)
    }
    
    func getDataModel()->SVGNodeModel {
        return model
    }
    
    func nodeInfo() -> String {
        return "\(model.index)"
    }
    
    static func == (lhs: SVGTreeModelNode, rhs: SVGTreeModelNode) -> Bool {
        return lhs.index == rhs.index
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return SVGTreeModelNode(model: self)
    }
    
    func node() -> Node<SVGTreeModelNode> {
        let node = Node<SVGTreeModelNode>.init(data: self)
        node.data.deep = deep
        node.data.index = index
        return node
    }
    
    func updateNodeParent(parent:Node<SVGTreeModelNode>?){
        if let p = parent {
            model.parentNode = p.data.getDataModel()
            model.parentType = p.data.getDataModel().type
        }
    }
    
    func parse(update tree:inout SVGTreeModel) {
        print("🍎 \(index) \(deep) \(element.name)")
        model.update(element: element)
        if model.type == .clipPath || model.parentType == .clipPath {
            tree.updateClipPath(model: model)
        }
        else if (model.type == .defs || model.parentType == .defs) {
            if model.type != .style {
                tree.updateDefinePath(model: model)
            }
            else {
                tree.style = StyleSheet(string: model.dataTxt) ?? StyleSheet()
            }
        }
        else if model.type == .style {
            tree.style = StyleSheet(string: model.dataTxt) ?? StyleSheet()
        }
        else {
            if let parent = model.parentNode {
                parent.childs.append(model)
            }
            else if model.parentType != .defs && model.parentType != .clipPath {
                tree.root = model
            }
            
            tree.listNodes.append(model)
            tree.updateMemoryTreeSize(size: model.memorySize)
        }
        tree.updateMemoryTreeSize(size: model.memorySize)
    }
    
    func generateCode(codemaker:CodeGenerationProtocol) -> String {
        let code = ""
        return code
    }
}

class SVGTreeModel {
    var layerName:String?
    var frame:CGRect = .zero
    var style:StyleSheet!
    var clipPaths:[SVGNodeModel] = []
    var definePaths:[SVGNodeModel] = []
    var listNodes:[SVGNodeModel] = []
    var root:SVGNodeModel?
    var current:SVGNodeModel?
    
    var description:String { return "Tree with \(listNodes.count) nodes and size \(memorySize/1024) kb" }
    
    private var treeSize:Int = MemoryLayout<SVGTreeModel>.stride
    
    init(layerName:String){
        self.layerName = layerName
    }
    
    public var memorySize:Int {
        return treeSize
    }
    
    func updateMemoryTreeSize(size:Int) {
        treeSize += size
    }
    
    class func buildTree(name:String, element:XML.Element) -> SVGTreeModel {
        var tree = SVGTreeModel(layerName: name)
        // Do Breadth First Traverse on SVG Dom Tree
        var index = 0
        var deep = 0
        let queueObj = Queue<SVGTreeModelNode>()
        let node = SVGTreeModelNode.init(element: element, index: index, deep: deep).node()
        _ = queueObj.enQueue(node: node)
        while !queueObj.isEmpty {
            let objFront = queueObj.queueFront()
            _ = queueObj.deQueue()
            objFront?.data.parse(update: &tree)
            if let childs = objFront?.data.element.childElements {
                deep = (objFront?.data.deep ?? 0) + 1
                for item in childs {
                    let newNode = SVGTreeModelNode.init(element: item, index: index, deep: deep).node()
                    newNode.data.updateNodeParent(parent: objFront)
                    _ = queueObj.enQueue(node: newNode)
                    
                    index = index + 1
                }
            }
        }
        return tree
    }
 
    func updateClipPath(model:SVGNodeModel) {
        if let data = model.nodeData as? SVGClipPath {
            if data.id != "" {
                clipPaths.append(model)
            }
        }
    }
    
    func updateDefinePath(model:SVGNodeModel) {
        if model.id != "" {
            definePaths.append(model)
        }
    }
    
    func findReference(id:String, isDefs:Bool = false) -> SVGNodeModel? {
        var model:SVGNodeModel?
        if isDefs == true {
            for ele in clipPaths {
                if ele.id == id {
                    model = ele
                    break
                }
            }
        }
        else {
            for ele in definePaths {
                if ele.id == id {
                    model = ele
                    break
                }
            }
        }
        return model
    }
    
    func getCode(codemaker:CodeGenerationProtocol, model:SVGNodeModel) -> String {
        var code = ""
        switch model.type {
        case .rect:
            code += codemaker.makeRect(model: model, tree: self)
            break
        case .path:
            code += codemaker.makePath(model: model, tree: self)
            break
        case .circle:
            code += codemaker.makeCircle(model: model, tree: self)
            break
        case .ellipse:
            code += codemaker.makeEllipse(model: model, tree: self)
            break
        case .line:
            code += codemaker.makeLine(model: model, tree: self)
            break
        case .polyline:
            code += codemaker.makePolyline(model: model, tree: self)
            break
        case .polygon:
            code += codemaker.makePolygon(model: model, tree: self)
            break
        case .radialGradient:
            code += codemaker.makeRadialGradient(model: model, tree: self)
            break
        case .text:
            code += codemaker.makeText(model: model, tree: self)
            break
        case .use:
            code += codemaker.makeUse(model: model, tree: self)
            break
        case .glyph:
            code += codemaker.makeGlyph(model: model, tree: self)
            break
        case .clipPath:
            code += codemaker.makeClipPath(model: model, tree: self)
            break
        case .defs:
            code += codemaker.makeDefs(model: model, tree: self)
            break
        case .g:
            code += codemaker.makeGrapth(model: model, tree: self)
            break
        case .svg:
            code += codemaker.makeSVG(model: model, tree: self)
        default:
            break
        }
        return code
    }
    
    class func test() {
        let svgContent = NSString.getTemplate(filename: "winter.svg")
        let xml = try! XML.parse(svgContent)
        if let element = xml["svg"].element {
            let tree = SVGTreeModel.buildTree(name: "winter", element: element)
            print(tree.description)
        }
    }
    
    deinit {
        clipPaths.removeAll()
        definePaths.removeAll()
        listNodes.removeAll()
        root = nil
        treeSize = 0
    }
}
