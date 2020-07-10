//
//  Array+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

//MARK: - String TraceLog + QySVG
extension Array where Element == String {
    mutating func addInfo(text:String) {
        let html = "\(count.line)\(text.content)".lineInfo
        append(html)
    }
    
    mutating func addWaring(text:String) {
        let html = "\(count.line)\(text.contentWaring)".lineWarning
        append(html)
    }
    
    mutating func addError(text:String) {
        let html = "\(count.line)\(text.contentError)".lineError
        append(html)
    }
}
