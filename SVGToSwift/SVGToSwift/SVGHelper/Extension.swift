//
//  Extension.swift
//  SVGToSwift
//
//  Created by Le Quang on 10/10/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa


extension String {
    var colorPrefix: String { return "#" }
    
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
    
    func swiftHex()->String {
        let hex = "#\(self)".mapToSixColorHex()
        return "\"#\(hex)\""
    }
    func swiftStr()->String { return "\"\(self)\"" }
    func objStr()->String {return "@\"\(self)\""}
}
