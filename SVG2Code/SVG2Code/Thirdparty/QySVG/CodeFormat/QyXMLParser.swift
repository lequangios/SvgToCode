//
//  QyXMLParser.swift
//  SVG2Code
//
//  Created by Le Quang on 7/3/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    func join() -> String {
        var value = ""
        for data in self.enumerated() {
            value += " \(data.element.key)=\(data.element.value.quote)"
        }
        return value
    }
    func join(style:QySVGFomatterStyle) -> String {
        var value = ""
        for data in self.enumerated() {
            value += "<span \(style.attributeStyle)>\(data.element.key)</span><span \(style.operactorStyle)>=</span><span \(style.attributeValueStyle)>\(data.element.value.quote)</span>"
        }
        return value
    }
}

protocol QyDebugAble {
    static func test()
}

protocol QyXMLParserProtocol {
    func startParsing(element:QyXMLParser.Element)
    func endParsing(element:QyXMLParser.Element)
}

class QyStack<T> {
    private let maxStackItems:Int = 1000
    private var list:[T] = []
    var count:Int { return list.count }
    var isEmpty:Bool { return list.count == 0}
    var nodeSize:Int { MemoryLayout<T>.stride }
    var stackSize:Int { list.count * nodeSize }
    var isOutMemory:Bool { return list.count > maxStackItems }
    var head:T? { return list.first}
    func push(data:T) { list.insert(data, at: 0) }
    func pop() { if isEmpty == false { list.remove(at: 0)} }
    func empty() { list.removeAll() }
    deinit {
        list.removeAll()
    }
}

class QyQueue<T>{
    private let maxQueueItems:Int = 1000
    private var list:[T] = []
    var count:Int { return list.count }
    var isEmpty:Bool { return list.count == 0}
    var nodeSize:Int { MemoryLayout<T>.stride }
    var queueSize:Int { list.count * nodeSize }
    var isOutMemory:Bool { return list.count > maxQueueItems }
    var head:T? { return list.first}
    func enQueue(data:T) { list.append(data) }
    func deQueue() { if list.count > 0 { list.remove(at: 0)} }
    func empty() { list.removeAll() }
    deinit {
        list.removeAll()
    }
}

class QyXMLParser : BaseFoundationObject {
    class Element {
        var tag:String
        var deep:Int = 0
        var index:Int = 0
        private var rawList:[String] = []
        private var htmlList:[String] = []
        private var i1:Int = 0
        private var i2:Int = 0
        private var style:QySVGFomatterStyle = .xcode
        var attributes:[String:String]?
        var text:String = ""
        var childs:[Element] = []
        weak var parent:Element?
        var rawData:String { return rawList.joined() }
        var htmlData:String {
//            htmlList.insert("<p \(style.blockStyle)>", at: 0)
//            htmlList.append("</p>")
            let html = htmlList.joined()
            return html.box
        }
        var isRoot:Bool { return parent == nil }
        var isEmptyText:Bool = true
        var isSelfCloseTag:Bool { return isEmptyText && childs.count == 0 }
        var isEmptyTag:Bool { return isSelfCloseTag && attributes?.count == 0 }
        init(tag:String) {
            self.tag = tag
        }
        init(tag:String, style:QySVGFomatterStyle) {
            self.tag = tag
            self.style = style
        }
        
        func beg(){
            beginTag()
            beginHTML(style: style)
        }
        
        func end(){
            endTag()
            endHTML(style: style)
        }
        
        private func beginTag(){
            var value = "\(String.tab(number: deep))<\(tag)"
            if let attr = attributes { value += attr.join() }
            i1 = rawList.count
            rawList.append(value)
        }
        private func endTag(){
            if isSelfCloseTag {
                rawList[i1].append(contentsOf: "/>")
            }
            else {
                rawList[i1].append(contentsOf: ">")
                if isEmptyText == false {
                    if QyCSSPaser.isCSS(tag: tag) {
                        let css = QyCSSPaser(rawData: text, tab: deep+1)
                        rawList.append(contentsOf: css.rawList)
                    }
                    else { rawList.append("\(String.tab(number: deep+1))\(text)") }
                }

                for e in childs {
                    rawList.append(contentsOf: e.rawList)
                }
                let value = "\(String.tab(number: deep))</\(tag)>"
                rawList.append(value)
            }
        }
        private func beginHTML(style:QySVGFomatterStyle) {
            /*
            var html = "<p \(style.paddingLeft(tab: deep))><span \(style.operactorStyle)><</span><span \(style.tagStyle)>\(self.tag)</span>"
            if let atrr = attributes { html.append(contentsOf: atrr.join(style: style)) }
             */
            
            var html = "\("<".operator)\(tag.tag)"
            if let attr = attributes { html.append(contentsOf: attr.joined()) }
            i2 = htmlList.count
            htmlList.append(html)
        }
        private func endHTML(style:QySVGFomatterStyle) {
            if isSelfCloseTag {
                //htmlList[i2].append(contentsOf: "<span \(style.operactorStyle)>/></span></p>")
                var html = htmlList[i2]
                html.append(contentsOf: "/>".operator)
                htmlList[i2] = html.line(withTab: deep)
            }
            else {
                /*
                htmlList[i2].append(contentsOf: "<span \(style.operactorStyle)>></span></p>")
                if isEmptyText == false {
                    if QyCSSPaser.isCSS(tag: tag) {
                        let list = QyCSSPaser.init(rawData: text, tab: deep+1, style: style)
                        htmlList.append(contentsOf: list.htmlList)
                    }
                    else {
                        let textTag = "<p \(style.paddingLeft(tab: deep+1))><span \(style.contentValueStyle)>\(text)</span></p>"
                        htmlList.append(textTag)
                    }
                }
                if childs.count > 0 {
                    for e in childs {
                        htmlList.append(contentsOf: e.htmlList)
                    }
                }
                
                let closeTag = "<p \(style.paddingLeft(tab: deep))><span \(style.operactorStyle)><</span><span \(style.tagStyle)>\(tag)</span><span \(style.operactorStyle)>></span></p>"
                htmlList.append(closeTag)
                */
                var html = htmlList[i2]
                html.append(contentsOf: ">".operator)
                htmlList[i2] = html.line(withTab: deep)
                if isEmptyText == false {
                    if QyCSSPaser.isCSS(tag: tag) {
                        let list = QyCSSPaser.init(rawData: text, tab: deep+1, style: style)
                        htmlList.append(contentsOf: list.htmlList)
                    }
                    else {
                        htmlList.append(text.content.line(withTab: deep+1))
                    }
                }
                if childs.count > 0 {
                    for e in childs {
                        htmlList.append(contentsOf: e.htmlList)
                    }
                }
                let endHtml = "\("<".operator)\(tag.tag)\(">".operator)"
                htmlList.append(endHtml.line(withTab: deep))
            }
        }
        
        
        deinit {
            childs.removeAll()
            attributes?.removeAll()
        }
    }
    fileprivate(set) var index:Int = 0
    fileprivate(set) var beaultyXML:String = ""
    private(set) var xmlString:String = ""
    private(set) var rawList:[String] = []
    private(set) var htmlList:[String] = []
    private(set) var element:Element!
    private(set) var parserStack:QyStack<Element>
    private(set) var theme:QySVGFomatterStyle = .xcode
    var delegate:QyXMLParserProtocol?
    init(xmlString:String) {
        self.xmlString = xmlString
        parserStack = QyStack<Element>()
        super.init()
        self.domain = "com.mobilecodelab.QyXMLParser"
    }
    
    func parseXML() throws {
        if let data = xmlString.data {
            let parser = XMLParser(data: data)
            parser.delegate = self
            let success = parser.parse()
            if !success {
                if let e = parser.parserError {
                    throw e
                }
            }
            else {
                if element != nil { beaultyXML = element.rawData}
            }
        }
        else { throw QyXMLParser.emptyInputError }
    }
}

extension QyXMLParser : QyDebugAble {
    static var errorDomain:String = "com.mobilecodelab.QyXMLParser"
    enum ErrorCode : Int {
        case emptyInputXML = 10001
    }
    static let emptyInputError = NSError.init(domain: QyXMLParser.errorDomain, code: QyXMLParser.ErrorCode.emptyInputXML.rawValue, description: "", failureReason: "") as Error
    static func test() {
        do {
            let svgContent = NSString.getTemplate(filename: "green.svg")
            let parser = QyXMLParser(xmlString: svgContent)
            try parser.parseXML()
            print(parser.element.childs.count)
            print(parser.element.childs.count)
        }
        catch let e {
            print(e.failureReason)
        }
    }
}

extension QyXMLParser : XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser){
        
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        let element = Element(tag: elementName)
        element.attributes = attributeDict
        element.index = self.index
        element.deep = parserStack.count
        element.beg()
        if self.element == nil { self.element = element }
        else {
            if let head = parserStack.head {
                element.parent = head
                head.childs.append(element)
            }
        }
        parserStack.push(data: element)
        if let handle = self.delegate {
            handle.startParsing(element: element)
        }
        self.index += 1
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let head = parserStack.head, string.isEmpty == false {
            head.text.append(string)
            head.isEmptyText = false
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let head = parserStack.head {
            if head.tag == elementName {
                head.end()
                parserStack.pop()
                if let handle = self.delegate {
                    handle.endParsing(element: head)
                }
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser){
        
    }
}
