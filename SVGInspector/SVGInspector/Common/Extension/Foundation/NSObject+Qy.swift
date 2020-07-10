//
//  NSObject+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/9/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

extension NSObject {
    struct Object {
        static var kIdentify:UInt8 = 0
        static var kPriority:UInt8 = 0
        static var kIsFocus:UInt8 = 0
        static var kState:UInt8 = 0
    }
    struct State : Equatable {
        var rawValue:String = ""
        static let loading:State = .init(rawValue: "loading")
        static let normal:State = .init(rawValue: "normal")
    }
    var name:String {return String(describing: self)}
    var identify:String {
        get {
            if let name = objc_getAssociatedObject(self, &(Object.kIdentify)) as? String {
                return name
            }
            return ""
        }
        set {
            objc_setAssociatedObject(self, &(Object.kIdentify), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var priority:Int {
        get {
            if let num = objc_getAssociatedObject(self, &(Object.kPriority)) as? String {
                return Int(num) ?? 0
            }
            return 0
        }
        set {
            objc_setAssociatedObject(self, &(Object.kPriority), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var isfocus:Int {
        get {
            if let num = objc_getAssociatedObject(self, &(Object.kIsFocus)) as? Int {
                return num
            }
            return -1
        }
        set {
            objc_setAssociatedObject(self, &(Object.kIsFocus), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    var state:State {
        get {
            if let name = objc_getAssociatedObject(self, &(Object.kIdentify)) as? State {
                return name
            }
            return .normal
        }
        set {
            objc_setAssociatedObject(self, &(Object.kIdentify), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
