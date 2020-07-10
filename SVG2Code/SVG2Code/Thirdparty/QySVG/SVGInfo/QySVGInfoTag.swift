//
//  QySVGInfoTag.swift
//  SVG2Code
//
//  Created by Le Quang on 6/28/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

struct QySVGLogTag {
    var tags:[String] = []
    var errorStyle:String = ""
    var infoStyle:String = ""
    var warningStyle:String = ""
    var lineStyle:String = ""
    var background:String = ""
    var allogs:String {
        return "<div style=\"font-family: SF Pro Text,SF Pro Icons,Helvetica Neue,Helvetica,Arial,sans-serif; font-size: 14px;\">\(tags.joined())</div>"
    }
    
    static let bootstrap:QySVGLogTag = .init(tags: [], errorStyle: "color: #721c24;", infoStyle: "color: #0c5460;", warningStyle: "color: #856404;", lineStyle: "color: #155724; width:20px", background: "background-color: #ffffff;")
    
    mutating func infoTag(text:String){
        let data = "<p style=\"\(background)\"><span style=\"\(lineStyle)\"><b>\(tags.count). </b></span><span style=\"\(infoStyle)\">\(text)</span></p>"
        tags.append(data)
    }
    mutating func warningTag(text:String){
        let data = "<p style=\"\(background)\"><span style=\"\(lineStyle)\"><b>\(tags.count). </b></span><span style=\"\(warningStyle)\">\(text)</span></p>"
        tags.append(data)
    }
    mutating func errorTag(text:String){
        let data = "<p style=\"\(background)\"><span style=\"\(lineStyle)\"><b>\(tags.count). </b></span><span style=\"\(errorStyle)\">\(text)</span></p>"
        tags.append(data)
    }
}

//extension Array where Element == String {
//    mutating func addWarning(log text:String) {
//        let data = "<p><span>.\(count)</span><span>\(text)</span></p>"
//        append(data)
//    }
//    mutating func addError(log text:String) {
//        let data = "<p><span>.\(count)</span><span>\(text)</span></p>"
//        append(data)
//    }
//    mutating func addInfo(log text:String) {
//        let data = "<span>.\(count)</span><span>\(text)</span>"
//        append(data)
//    }
//}
