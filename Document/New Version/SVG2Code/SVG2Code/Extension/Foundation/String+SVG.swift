//
//  String+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

public typealias rgba = (r:Int, g:Int, b:Int, a:Double)

public extension CGFloat{
    var str:String{return String(format: "%.1f", self)}
}

extension String {
    var colorPrefix: String { return "#" }
    var floatValue: Float { return strtof(self, nil)}
    var doubleValue: Double { return strtod(self, nil)}
    
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
    
    func isURLValueString()->Bool{
        let check = "#[0-9A-Fa-f]{3}|#[0-9A-Fa-f]{6}"
        let check_value = NSPredicate(format:"SELF MATCHES %@", check)
        return check_value.evaluate(with: self)
    }
    
    func isHexColorString()->Bool{
        let check = "#[0-9A-Fa-f]{3}|#[0-9A-Fa-f]{6}"
        let check_value = NSPredicate(format:"SELF MATCHES %@", check)
        return check_value.evaluate(with: self)
    }
    
    func mapToSixColorHex()-> String {
        if self.isHexColorString() && self.count == 4 {
            var colorhex = ""
            let str = self.trim(self.colorPrefix)
            for c in  str {
                colorhex += "\(c)\(c)"
            }
            return colorhex
        }
        return self.trim(colorPrefix)
    }
    
    func arraySubString(_ char:Character) -> [String] {
        let sliptStr = self.split(separator: char)
        var arr = sliptStr.map { return String($0) }
        if arr.count == 0 { arr.append(self) }
        return arr
    }
    
    func trim(_ prefix: String) -> String {
        return hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }
    
    func trimlast(_ suffix: String) -> String {
        return hasSuffix(suffix) ? String(self.dropLast(suffix.count)) : self
    }
    
    func objStr()->String {return "@\"\(self)\""}
    
    public func extractRGBA() ->rgba{
        let value = strtoul(trim(colorPrefix), nil, 16)
        let b = value & 0xFF;
        let g = (value >> 8) & 0xFF;
        let r = (value >> 16) & 0xFF;
        
        return (r:Int(r), g:Int(g), b:Int(b), a:1.0)
    }
    
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal, range: nil)
    }
    
    func replace(strings: [String], replacements: [String]) -> String {
        var temp = self
        for (index, string) in strings.enumerated() {
            temp = temp.replacingOccurrences(of: string, with: replacements[index], options: .literal, range: nil)
        }
        return temp
    }
}

