//
//  Extension.swift
//  SVGToSwift
//
//  Created by Le Quang on 10/10/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa

public typealias rgba = (r:Int, g:Int, b:Int, a:Double)

extension String {
    var colorPrefix: String { return "#" }
    
    func isHexColorString()->Bool{
        let check = "#[0-9A-Fa-f]{3}|#[0-9A-Fa-f]{6}"
        let check_value = NSPredicate(format:"SELF MATCHES %@", check)
        return check_value.evaluate(with: self)
    }
    
    public var colorValue:NSColor {
        if let color = NSColor.init(hexString: self) {
            return color
        }
        else {
            print("\(self) is nil color")
            return NSColor.clear
        }
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
    
    public func extractRGBA() ->rgba{
        let value = strtoul(trim(colorPrefix), nil, 16)
        let b = value & 0xFF;
        let g = (value >> 8) & 0xFF;
        let r = (value >> 16) & 0xFF;
        
        return (r:Int(r), g:Int(g), b:Int(b), a:1.0)
    }
}

extension NSColor {
    convenience init(red: Int, green: Int, blue: Int, alpha:CGFloat) {
        let divisor: CGFloat = 255
        self.init(
            red: CGFloat(red) / divisor,
            green: CGFloat(green) / divisor,
            blue: CGFloat(blue) / divisor,
            alpha: alpha
        )
    }
    
    public convenience init?(hexString: String){
        if hexString.isHexColorString() == true {
            let rgb = hexString.extractRGBA()
            if rgb.g == 15 && rgb.b == 255 { print(hexString) }
            self.init(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)
        }
        else { return nil }
    }
}

extension CAShapeLayer {
    func fill(_ hexColor:String){
        self.fillColor = hexColor.colorValue.cgColor
    }
}

extension NSBezierPath {
    func fillWithHex(_ hexColor:String){
        hexColor.colorValue.setFill()
        self.fill()
    }
    
    func strokeWithHex(_ hexColor:String){
        hexColor.colorValue.setStroke()
        self.stroke()
    }
}
