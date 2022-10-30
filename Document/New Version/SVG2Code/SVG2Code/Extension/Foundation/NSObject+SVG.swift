//
//  NSObject+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

private var kNSObjectIdentify: UInt8 = 0
private var kNSObjectPriority: UInt8 = 0
private var kNSObjectIsFocus: UInt8 = 0

extension NSObject {
    var name:String {return String(describing: self)}
    var identify:String {
        get {
            if let name = objc_getAssociatedObject(self, &kNSObjectIdentify) as? String {
                return name
            }
            return ""
        }
        set {
            objc_setAssociatedObject(self, &kNSObjectIdentify, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var priority:Int {
        get {
            if let num = objc_getAssociatedObject(self, &kNSObjectPriority) as? String {
                return Int(num) ?? 0
            }
            return 0
        }
        set {
            objc_setAssociatedObject(self, &kNSObjectPriority, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var isfocus:Int {
        get {
            if let num = objc_getAssociatedObject(self, &kNSObjectIsFocus) as? Int {
                return num
            }
            return -1
        }
        set {
            objc_setAssociatedObject(self, &kNSObjectIsFocus, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
