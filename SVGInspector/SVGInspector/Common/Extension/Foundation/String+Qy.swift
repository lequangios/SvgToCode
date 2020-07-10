//
//  String+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

//MARK: - Add custom value to String
extension Substring {
    var value:String { return String(self) }
}

//MARK: - Add custom value to String
extension String {
    var localized:String { return NSLocalizedString(self, comment: "Localized String for key : \(self)") }
    var number:NSNumber {
        return NSNumber(value: strtod(self, nil))
    }
    
    var isEmpty:Bool {
        let pattern = "([ \t\n\r]+)"
        return (count == 0) || isMatch(withPattern: pattern)
    }
    
    var data:Data? { return self.data(using: .utf8) }
    
    var range:NSRange { return NSRange(location: 0, length: self.count) }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    func repeating(count:Int) -> String { return String(repeating: self, count: count) }
    
    func substring(with range:NSTextCheckingResult) -> String {
        return self[range.range.lowerBound..<(range.range.length+range.range.lowerBound)]
    }
    
    func substring(with range:NSRange) -> String {
        return self[range.lowerBound..<(range.length + range.lowerBound)]
    }
    
    func trim(_ prefix: String) -> String {
        return hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }
    
    func trimlast(_ suffix: String) -> String {
        return hasSuffix(suffix) ? String(self.dropLast(suffix.count)) : self
    }
}

//MARK: - String and Color
public typealias rgba = (r:Int, g:Int, b:Int, a:Double)
extension String {
    var colorPrefix:String { return "#" }
    var isHexColorString:Bool {
        let check = "#[0-9A-Fa-f]{3}|#[0-9A-Fa-f]{6}"
        let check_value = NSPredicate(format:"SELF MATCHES %@", check)
        return check_value.evaluate(with: self)
    }
    var rgba:rgba {
        let value = strtoul(trim(colorPrefix), nil, 16)
        let b = value & 0xFF;
        let g = (value >> 8) & 0xFF;
        let r = (value >> 16) & 0xFF;
        
        // Hex 3 value : #120
        if count == 4 {
            return (Int(r)*15, Int(g)*15, Int(b)*15, 1)
        }
        else {
            return (Int(r), Int(g), Int(b), 1)
        }
    }
}

//MARK: - Add Regex Method to String
extension String {
    func isMatch(withPattern pattern:String) -> Bool {
        let regex = NSPredicate(format:"SELF MATCHES %@", pattern)
        return regex.evaluate(with: self)
    }
    
    func find(withPattern pattern:String, option:NSRegularExpression.Options = .caseInsensitive) -> [QyMatchPaternResult] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: option)
            return regex.matches(in: self, options: [], range: range).map{
                QyMatchPaternResult(range: $0.range, value: self.substring(with: $0))
            }
        }
        catch let e {
            print("\(e.localizedDescription)")
            return []
        }
    }
    
    func findFirst(withPattern pattern:String, option:NSRegularExpression.Options = .caseInsensitive) -> QyMatchPaternResult? {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: option)
            if let result = regex.firstMatch(in: self, options: [], range: range) {
                return QyMatchPaternResult(range: result.range, value: self.substring(with: result))
            }
            return nil
        }
        catch let e {
            print("\(e.localizedDescription)")
            return nil
        }
    }
}

//MARK: - String and CSS/HTML/XML
extension String {
    // Drop css key value to Dictionary
    func split(byPair pair:Character, group:Character) -> [String:String] {
        var dicts:[String:String] = [:]
        var key = "", value = ""
        var keyBg = true, valueBg = false
        for c in self {
            if keyBg == true {
                if c == pair {
                    keyBg = false
                    valueBg = true
                }
                else { key.append(c) }
            }
            else  if valueBg == true {
                if c == group {
                    dicts[key] = value
                    key = ""
                    value = ""
                    valueBg = false
                    keyBg = true
                }
                else { value.append(c) }
            }
        }
        return dicts
    }
    
    func find(inTag tag:String, pattern:String = ".+") -> [QyMatchPaternResult] {
        let pattern = "(?<=<\(tag)>)\(pattern)?(?=<//\(tag)>)"
        return find(withPattern: pattern)
    }
    
    func find(inGroup group:String, pattern:String = ".+") -> [QyMatchPaternResult] {
        let pattern = "(?<=\(group))\(pattern)?(?=//\(group))"
        return find(withPattern: pattern)
    }
    
    var dropValueFromURLValue:String {
        var start = false
        var value = ""
        for i in self {
            if i == "(" {
                start = true
                continue
            }
            
            if start == true && i != ")" {
                value += String(i)
            }
        }
        return value
    }
}

//MARK: - String QySVGFomatterStyle + QyAppTemplate
extension String {
    static var tab:String = "&emsp;"
    var rightSpace:String { return "\(self) " }
    var quote:String { return "\"\(self)\"" }
    var style:String { return "style=\"\(self)\"" }
    var box:String { return "<div \(Template.codeFormatter.blockStyle.style)>\(self)</div>" }
    var `operator`:String { return "<span \(Template.codeFormatter.operactorStyle.style)><b>\(self)</b></span>" }
    var tag:String {
        let css = "\(Template.codeFormatter.font)\(Template.codeFormatter.tagStyle)"
        return "<span \(css.style)>\(self.rightSpace)</span>"
    }
    var attribute:String { return "<span \(Template.codeFormatter.attributeStyle.style)>\(self)</span>" }
    var attributeValue:String { return "<span \(Template.codeFormatter.attributeValueStyle.style)>\(self.rightSpace)</span>"}
    var keyword:String { return "<span \(Template.codeFormatter.keywordStyle.style)><b>\(self)</b></span>" }
    var content:String { return "<span \(Template.codeFormatter.contentValueStyle.style)>\(self)</span>" }
    var contentWaring:String { return "<span \(Template.codeFormatter.contentWaringValueStyle.style)>\(self)</span>" }
    var contentError:String { return "<span \(Template.codeFormatter.contentErrorValueStyle.style)>\(self)</span>" }
    var lineInfo:String { return "<p \(Template.codeFormatter.lineStyle.style)>\(self)</p>" }
    var lineWarning:String { return "<p \(Template.codeFormatter.lineWaringStyle.style)>\(self)</p>" }
    var lineError:String { return "<p \(Template.codeFormatter.lineErrorStyle.style)>\(self)</p>" }
    
    func line(withTab tab:Int) -> String {
        let css = "\(Template.codeFormatter.lineStyle )"
        let t = String(repeating: String.tab, count: tab)
        return "<p \(css.style)>\(t)\(self)</p>"
    }
    
    func line(withTap tab:Int, lineNumber:Int) -> String {
        return "<p \(Template.codeFormatter.lineStyle.style)><span \(Template.codeFormatter.lineNumberStyle.style)>\(lineNumber)<span><span \(Template.codeFormatter.left(tab: tab).style)>\(self)</span><p>"
    }
}

//MARK: - String TraceLog + QySVG
extension String {
    
}
