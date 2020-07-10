//
//  QySVGValues.swift
//  SVG2Code
//
//  Created by Le Quang on 6/11/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics
import QuartzCore

protocol QySVGValueProtocol {
    var priority:QySVGValuePriority {get set}
    var rawValue:String { get }
    var type:QySVGValueType { get }
    init(rawValue:String, priority:QySVGValuePriority)
}




//struct QySVGMatrixValue : QySVGValueProtocol {
//    var rawValue:String
//    var a,b,c,d,e,f :NSNumber
//    var type:QySVGValueType 
//    var priority:QySVGValuePriority = .initial
//    private let pattern = "[0-9.-+]+"
//    private let rawPattern = "mattrix/(([0-9.-+ ])/)"
//    init(rawValue:String, priority:QySVGValuePriority = .initial) {
//        self.rawValue = rawValue
//        self.priority = priority
//        self.type = .absolute
//        let u = rawValue.find(withPattern: pattern).map({$0.value})
//        if u.count >= 6 {
//            a = u[0].number
//            b = u[0].number
//            c = u[0].number
//            d = u[0].number
//            e = u[0].number
//            f = u[0].number
//        }
//        else {
//            a = NSNumber(value: 0)
//            b = NSNumber(value: 0)
//            c = NSNumber(value: 0)
//            d = NSNumber(value: 0)
//            e = NSNumber(value: 0)
//            f = NSNumber(value: 0)
//        }
//    }
//}

//struct QySVGTranslateValue {
//    var rawValue:String
//    var x,y :NSNumber
//    var priority:QySVGValuePriority = .initial
//    private let pattern = "[0-9.-+]+"
//}

//
//
//struct QySVGDashArrayValue {
//    var value:[NSNumber] = []
//    var priority:QySVGValuePriority = .initial
//    private var pattern:String = "([0-9]*(.)[0-9]+)|[0-9]+"
//    init(rawValue:String, priority:QySVGValuePriority = .initial) {
//        self.priority = priority
//        if rawValue != "none" {
//            value = rawValue.find(withPattern: pattern).map{$0.value.number}
//        }
//    }
//}
//
//struct QySVGColorValue {
//    var value:NSColor = .clear
//    var rawValue:String
//    var priority:QySVGValuePriority = .initial
//    private var pattern1 = "#[0-9A-Fa-f]{3}"
//    private var pattern2 = "#[0-9A-Fa-f]{6}"
//    init(rawValue:String, priority:QySVGValuePriority = .initial) {
//        self.rawValue = rawValue
//        self.priority = priority
//        if self.rawValue.isMatch(withPattern: pattern1) {
//            self.rawValue = self.rawValue.map{String([$0,$0])}.joined()
//            if let value = NSColor(hexString: self.rawValue) { self.value = value }
//            else { print("color error \(self.rawValue)") }
//        }
//        else if self.rawValue.isMatch(withPattern: pattern2) {
//            if let value = NSColor(hexString: self.rawValue) { self.value = value }
//            else { print("color error \(self.rawValue)") }
//        }
//        else {
//            if let value = NSColor(named: self.rawValue) { self.value = value }
//            else { print("color error \(self.rawValue)") }
//        }
//    }
//}
//
//struct QySVGPaintValue {
//    var value:[Any] = []
//    var rawValue:String
//    var priority:QySVGValuePriority = .initial
//    init(rawValue:String, priority:QySVGValuePriority = .initial){
//        self.rawValue = rawValue
//        self.priority = priority
//    }
//}
//
//struct QySVGURLValue {
//    var value:String
//    var rawValue:String
//    var priority:QySVGValuePriority = .initial
//    init(rawValue:String, priority:QySVGValuePriority = .initial) {
//        self.rawValue = rawValue
//        self.value = rawValue
//        self.priority = priority
//    }
//}
//
//struct QySVGStopColor {
//    var value:NSColor = .clear
//    var rawValue:String
//    var priority:QySVGValuePriority = .initial
//    private var pattern1 = "#[0-9A-Fa-f]{3}"
//    private var pattern2 = "#[0-9A-Fa-f]{6}"
//    init(rawValue:String, priority:QySVGValuePriority = .initial) {
//        self.rawValue = rawValue
//        self.priority = priority
//        if self.rawValue.isMatch(withPattern: pattern1) {
//            self.rawValue = self.rawValue.map{String([$0,$0])}.joined()
//            if let value = NSColor(hexString: self.rawValue) { self.value = value }
//            else { print("stop color error \(self.rawValue)") }
//        }
//        else if self.rawValue.isMatch(withPattern: pattern2) {
//            if let value = NSColor(hexString: self.rawValue) { self.value = value }
//            else { print("stop color error \(self.rawValue)") }
//        }
//        else {
//            if let value = NSColor(named: self.rawValue) { self.value = value }
//            else { print("stop color error \(self.rawValue)") }
//        }
//    }
//    
//}
//
//struct QySVGStrokeColor {
//    var value:NSColor = .clear
//    var rawValue:String
//    var priority:QySVGValuePriority = .initial
//    var opacity:NSNumber = .init(value: 0)
//    private var pattern1 = "#[0-9A-Fa-f]{3}"
//    private var pattern2 = "#[0-9A-Fa-f]{6}"
//    init(rawValue:String, priority:QySVGValuePriority = .initial) {
//        self.rawValue = rawValue
//        self.priority = priority
//        if self.rawValue.isMatch(withPattern: pattern1) {
//            self.rawValue = self.rawValue.map{String([$0,$0])}.joined()
//            if let value = NSColor(hexString: self.rawValue) { self.value = value }
//            else { print("Stroke color error \(self.rawValue)") }
//        }
//        else if self.rawValue.isMatch(withPattern: pattern2) {
//            if let value = NSColor(hexString: self.rawValue) { self.value = value }
//            else { print("Stroke color error \(self.rawValue)") }
//        }
//        else {
//            if let value = NSColor(named: self.rawValue) { self.value = value }
//            else { print("Stroke color error \(self.rawValue)") }
//        }
//    }
//    mutating func add(opacity:String) {
//        self.opacity = opacity.number
//        self.value = self.value.with(alpha: self.opacity)
//    }
//}


