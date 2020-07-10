//
//  QyFomatter.swift
//  SVG2Code
//
//  Created by Le Quang on 7/3/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa


class QySVGFomatterStyle: NSObject {
    private let tabSize:Int = 10
    @objc dynamic var font:String                     = ""
    @objc dynamic var blockStyle:String               = ""
    @objc dynamic var operactorStyle:String           = ""
    @objc dynamic var tagStyle:String                 = ""
    @objc dynamic var attributeStyle:String           = ""
    @objc dynamic var attributeValueStyle:String      = ""
    @objc dynamic var contentValueStyle:String        = ""
    @objc dynamic var contentWaringValueStyle:String  = ""
    @objc dynamic var contentErrorValueStyle:String   = ""
    @objc dynamic var keywordStyle:String             = ""
    @objc dynamic var lineStyle:String                = ""
    @objc dynamic var lineWaringStyle:String          = ""
    @objc dynamic var lineErrorStyle:String           = ""
    @objc dynamic var lineNumberStyle:String          = ""
    
    func left(tab:Int) -> String { return "margin-left:\(tab*tabSize)px" }
    
    func paddingLeft(tab:Int) -> String {
        return "style=\"margin-left: \(10*tab)px;\""
    }
    
    
    init(rawText:String = "") {
        super.init()
        var text = rawText
        if text.isEmpty {
            do {
                text = try NSString.getTemplate(filename: "xcode.qy")
            }
            catch let e {
                fatalError(e.failureReason)
            }
        }
        var key = "", value = ""
        var tmp = ""
        for c in text {
            if c == "{" {
                // Complete Key
                key = tmp
                tmp = ""
            }
            else if c == "}" {
                // Complete Value
                value = tmp
                self.setValue(value, forKey: key)
                tmp = ""
                value = ""
                key = ""
            }
            else if c != "\n" && c != "#" && c != "\t"{
                tmp.append(c)
            }
        }
    }
    
    static let xcode:QySVGFomatterStyle = .init()
}

extension String {
    static func tab(number:Int) -> String { return String(repeating: "\t", count: number) }
    static func htmlTab(number:Int) -> String { return String(repeating: "&emsp;", count: number) }
    static func linebreak() -> String { return "\n" }
}
