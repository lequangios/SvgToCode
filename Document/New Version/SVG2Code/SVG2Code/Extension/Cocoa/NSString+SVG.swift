//
//  NSString+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa

extension NSString {
    class func getTemplate(filename:NSString) -> String {
        let type = filename.pathExtension
        let name = filename.deletingPathExtension
        if let filepath = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch let e {
                print("\(e.localizedDescription)")
                return ""
            }
        } else {
            print("\(name) with type \(type) not found")
            return ""
        }
    }
}
