//
//  NSColor+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

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
        if hexString.isHexColorString == true {
            let rgb = hexString.rgba
            self.init(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)
        }
        else { return nil }
    }
}

extension String {
    public var colorValue:NSColor {
        if let color = NSColor.init(hexString: self) {
            return color
        }
        else {
            return NSColor.clear
        }
    }
}

