//
//  BaseFoundationObject.swift
//  SVG2Code
//
//  Created by Le Quang on 7/5/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class BaseFoundationObject: NSObject, QyErrorProtocol, QyLogProtocol {
    var domain: String = "com.mobilecodelab."
    var logs: [String] = []
    var isAudit: Bool { return false }
    var begExc: UInt64 = 0
    var endExc: UInt64 = 0
}
