//
//  QyCSSPaser.swift
//  SVG2Code
//
//  Created by Le Quang on 7/4/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

protocol QyCSSPaserDelegate {
    func parseSelector(selector:String, attribute:[String:String])
}

class QyCSSPaser {
    static func isCSS(tag:String) -> Bool { return tag == "style" }
    private(set) var rawList:[String] = []
    private(set) var htmlList:[String] = []
    private var style:QySVGFomatterStyle = .xcode
    var rawData:String
    var tab:Int
    init(rawData:String, tab:Int) {
        self.rawData = rawData
        self.tab = tab
        parse()
    }
    
    init(rawData:String, tab:Int, style:QySVGFomatterStyle) {
        self.rawData = rawData
        self.tab = tab
        self.style = style
        self.parseCSS()
    }
    
    private func parse(){
        let t = String.tab(number: self.tab)
        var tmp = t
        for c in rawData {
            if c != "}" {
                tmp.append(c)
            }
            else {
                tmp.append("}")
                rawList.append(tmp)
                tmp = t
            }
        }
    }
    
    private func parseCSS(){
        var data = ""
        var value = ""
        for c in rawData {
            if c == "{" {
                //value.append(contentsOf: "<p \(style.paddingLeft(tab: tab))><span \(style.tagStyle)>\(data)</span><span \(style.operactorStyle)>{</span>")
                let html = "\(data.tag)\("{".operator)"
                value.append(contentsOf: html)
                data = ""
            }
            else if c == ":" {
                //value.append(contentsOf: "<span \(style.attributeStyle)>\(data)</span><span \(style.operactorStyle)>:</span>")
                let html = "\(data.attribute)\(":".operator)"
                value.append(contentsOf: html)
                data = ""
            }
            else if c == ";" {
                //value.append(contentsOf: "<span \(style.attributeValueStyle)>\(data)</span><span \(style.operactorStyle)>;</span>")
                let html = "\(data.attributeValue)\(";".operator)"
                value.append(contentsOf: html)
                data = ""
            }
            else if c == "}" {
                //value.append(contentsOf: "<span \(style.operactorStyle)>}</span></p>")
                value.append("\("}".operator)")
                htmlList.append(value.line(withTab: tab))
                data = ""
                value = ""
            }
            else {
                data.append(c)
            }
        }
    }
    
    private func parseCSS(name:String, value:String) {
        let attr = value.split(byPair: ":", group: ";")
        if attr.count > 0 {
            let v = attr.reduce("") { (html, dict) -> String in
                var value = html
                value.append(contentsOf: "<span \(style.attributeStyle)>\(dict.key)</span><span \(style.operactorStyle)>:</span><span \(style.attributeValueStyle)>\(dict.value)</span><span \(style.operactorStyle)>;</span>")
                return value
            }
            let newStr = "<p><span \(style.tagStyle)>\(name)</span><span \(style.operactorStyle)>{</span>\(v)<span \(style.operactorStyle)>}</span></p>"
            htmlList.append(newStr)
        }
    }
}
