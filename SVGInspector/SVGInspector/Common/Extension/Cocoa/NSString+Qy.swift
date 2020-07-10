//
//  NSString+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension NSString {
    class func getTemplate(filename:NSString) throws -> String {
        let type = filename.pathExtension
        let name = filename.deletingPathExtension
        if let filepath = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch let error {
                throw error
            }
        } else {
            let error = NSError(information: .fileNotFound, description: "\(name) with type \(type) not found", failureReason: "\(name) with type \(type) not found")
            throw error
        }
    }
}
