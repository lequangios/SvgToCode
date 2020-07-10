//
//  BaseError.swift
//  SVG2Code
//
//  Created by Le Quang on 7/5/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

struct BaseError {
    var code:Int = 0
    var domain:String = ""
    var description:String = ""
    var failureReason:String = ""
    
    var error:NSError {
        return NSError.init(domain: domain, code: code, description: description, failureReason: failureReason)
    }
}
