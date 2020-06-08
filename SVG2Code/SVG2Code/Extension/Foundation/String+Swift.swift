//
//  String+Swift.swift
//  SVG2Code
//
//  Created by Le Quang on 5/11/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

extension String {
    var swiftStr:String { return "\"\(self)\""}
    
    var swiftHexColor:String {
        let hex = "#\(self)".mapToSixColorHex()
        return "\"#\(hex)\""
    }
    
    var htmlDecode:String { return self.replace(strings: ["\n", "\"", "&"], replacements: ["\\n", "&quot;", "&amp;"])}
}
