//
//  QyLogProtocol.swift
//  SVG2Code
//
//  Created by Le Quang on 7/5/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

func tick() -> UInt64 { mach_absolute_time()/1000000 }

protocol QyLogProtocol {
    var logs:[String] {get set}
    var isAudit:Bool {get}
    var begExc:UInt64 {get set}
    var endExc:UInt64 {get set}
    func printl(_ items: Any...)
    func printf(_ items: Any...)
    func logTick()
}

extension QyLogProtocol {
    func printl(_ items: Any...) {
        if isAudit == true {
            print(items)
        }
    }
    func printf(_ items: Any...) {
        if isAudit == true {
            print("\(#function) \(items)")
        }
    }
    func logTick() { print("\(#function) executed in \(endExc - begExc) s") }
}
