//
//  SVGDataBuilder.swift
//  SVG2Code
//
//  Created by Le Quang on 5/21/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import JavaScriptCore

class SVGDataBuilder: NSObject {
    // MARK:- Build SVG Tree Model from XML String (New)
    class func buildTree(withName name:String, svgContent:String, audit:Bool, complete:@escaping(Result<MainViewModel.Model,Error>)->Void) {
        DispatchQueue.global(qos: .background).sync {
            do {
                let svg = try QySVG(svgContent: svgContent)
                svg.information.name = name
                svg.computedNodeAttributes()
                let model = MainViewModel.Model()
                model.svg = svg
                complete(.success(model))
            }
            catch let e { complete(.failure(e)) }
        }
    }
    
    // MARK:- Build Preview from SVG Tree Model (New)
    class func buildPreview(withTree tree:QySVG, complete:@escaping(Result<SVGPreviewModel,Error>)->Void){
        DispatchQueue.global(qos: .background).sync {
            if let _ = tree.rootNode {
                if let preview = tree.generatePreview() {
                    preview.code = QySVGCode(svgTextContent: tree.information.beautyHtml)
                    DispatchQueue.main.async {
                        complete(.success(preview))
                    }
                    return
                }
            }
            
            let error = NSError(domain: NSErrorDomain.svgXMLPaserDomain.rawValue, code: NSErrorCode.internalCode.rawValue, description: "Invalid SVG Tree Model", failureReason: "Invalid SVG Tree Model, please generate SVG Tree Model again!")
            DispatchQueue.main.async {
                complete(.failure(error))
            }
        }
    }
    
    // MARK:- Build SVG Tree Model from XML String
    class func buildTree(name:String, svgContent:String, audit:Bool, complete:@escaping(Result<SVGTreeModel,Error>)->Void) {
        DispatchQueue.global(qos: .background).sync {
            do {
                let xml = try XML.parse(svgContent)
                if let element = xml["svg"].element {
                    let tree = SVGTreeModel.buildTree(name: name, element: element)
                    tree.svgTree = try QySVG.buildTree(withXMLElement: element)
                    tree.svgCode = QySVGCode(svgTextContent: svgContent)
                    tree.svgCode?.beautifull()
                    if audit == true {
                        print(tree.description)
                    }
                    DispatchQueue.main.async {
                        complete(.success(tree))
                    }
                }
                else {
                    let error = NSError(domain: NSErrorDomain.svgXMLPaserDomain.rawValue, code: NSErrorCode.internalCode.rawValue, description: "Invalid xml syntax", failureReason: "Invalid xml, please generate xml again!")
                    DispatchQueue.main.async {
                        complete(.failure(error))
                    }
                }
            }
            catch let e {
                DispatchQueue.main.async {
                    complete(.failure(e))
                }
            }
        }
    }
    
    // MARK:- Build Preview from SVG Tree Model
    class func buildPreview(withTree tree:SVGTreeModel, complete:@escaping(Result<SVGPreviewModel,Error>)->Void){
        DispatchQueue.global(qos: .background).sync {
            if let root = tree.root {
                let tool = SVGPreviewGeneration()
                if let preview = tool.generatecode(model: root, tree: tree) {
                    let list = preview.layerList.sorted{ $1.value < $0.value }
                    preview.layerList.removeAll()
                    preview.code = tree.svgCode
                    
                    for item in list {
                        preview.layerList[item.key] = item.value
                    }
                    
                    DispatchQueue.main.async {
                        complete(.success(preview))
                    }
                    return
                }
            }
            
            let error = NSError(domain: NSErrorDomain.svgXMLPaserDomain.rawValue, code: NSErrorCode.internalCode.rawValue, description: "Invalid SVG Tree Model", failureReason: "Invalid SVG Tree Model, please generate SVG Tree Model again!")
            DispatchQueue.main.async {
                complete(.failure(error))
            }
        }
    }
    
    class func buildPreview(withTree tree:SVGTreeModel) -> (SVGPreviewModel?, Error?) {
        if let root = tree.root {
            let tool = SVGPreviewGeneration()
            if let preview = tool.generatecode(model: root, tree: tree) {
                //let preview = SVGPreviewModel(layer: layer, layerList: tool.layerTable, size: data.viewbox.size)
                return (preview,nil)
            }
        }
        
        let error = NSError(domain: NSErrorDomain.svgXMLPaserDomain.rawValue, code: NSErrorCode.internalCode.rawValue, description: "Invalid SVG Tree Model", failureReason: "Invalid SVG Tree Model, please generate SVG Tree Model again!")
        return (nil,error)
        
    }
    
    // MARK:- Build Code from SVG Tree Model
    class func buildCode(withTree tree:SVGTreeModel, codeMaker:CodeGenerationProtocol, complete:@escaping(Result<String,Error>)->Void) {
        DispatchQueue.global(qos: .utility).sync {
            
            //let code = codeMa
            if let root = tree.root {
                let code = codeMaker.generatecode(codemaker: codeMaker, model: root, tree: tree)
                DispatchQueue.main.async {
                    complete(.success(code))
                }
                
                /*
                do {
                    let presentcode = try SVGDataBuilder.convert(toHTML: code, language: codeMaker.name()) ?? code
                    DispatchQueue.main.async {
                        complete(.success(presentcode))
                    }
                    
                }
                catch let error {
                    DispatchQueue.main.async {
                        complete(.failure(error))
                    }
                }
                */
            }
            else {
                let error = NSError(domain: NSErrorDomain.svgXMLPaserDomain.rawValue, code: NSErrorCode.internalCode.rawValue, description: "Invalid SVG Tree Model", failureReason: "Invalid SVG Tree Model, please generate SVG Tree Model again!")
                DispatchQueue.main.async {
                    complete(.failure(error))
                }
                
            }
        }
    }
    
    // MARK:- Write Code to HTML file
    class func convert(toHTML code:String, language:String) throws -> String? {
        if let filepath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "HTML"){
            do {
                let content = try String(contentsOfFile: filepath)
                let html = try SVGDataBuilder.hightlight(WithPrism: code, language: language) ?? ""
                return content.replace(strings: ["{codedata}"], replacements: [html])
            }
            catch let e {
                throw e
            }
        }
        return ""
    }
    
    // MARK:- Hightlight Code
    class func hightlight(WithPrism code:String, language:String) throws -> String? {
        if let filepath = Bundle.main.path(forResource: "prism", ofType: "js", inDirectory: "HTML/js"), let context = JSContext(){
            do {
                let content = try String(contentsOfFile: filepath)
                context.evaluateScript(content)
                let function = context.objectForKeyedSubscript("hightligthCode")
                let result = function?.call(withArguments: [code, language])
                return result?.toString()
            }
            catch let error {
                throw error
            }
        }
        return nil
    }
}
