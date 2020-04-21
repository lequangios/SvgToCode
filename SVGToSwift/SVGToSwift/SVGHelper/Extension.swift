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
    func arraySubString(_ char:Character) -> [String] {
        let sliptStr = self.split(separator: char)
        var arr = sliptStr.map { return String($0) }
        if arr.count == 0 { arr.append(self) }
        return arr
    }
    
    func trim(_ prefix: String) -> String {
        return hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }
    
    func swiftHex()->String { return "\"#\(self)\"" }
    func swiftStr()->String { return "\"\(self)\"" }
    func objStr()->String {return "@\"\(self)\""}
}
