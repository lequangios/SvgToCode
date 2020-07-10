//
//  QySVGCode.swift
//  SVG2Code
//
//  Created by Le Quang on 6/29/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa
import Foundation

extension Array where Element == Character{
    mutating func push(c:Character) { insert(c, at: 0) }
    mutating func pop() { remove(at: 0) }
    var top:Character {
        if let top = first { return top }
        else {return "☠️"}
    }
}

struct QySVGCode : QyLogProtocol {
    struct Style {
        var rawValue:NSColor
        static let keyword:Style = .init(rawValue: "#ff6ea8".colorValue)
        static let attribute:Style = .init(rawValue: NSColor(red: 55, green: 148, blue: 174, alpha: 1))
        static let value:Style = .init(rawValue: NSColor(red: 123, green: 185, blue: 174, alpha: 1))
        static let operation:Style = .init(rawValue: NSColor(red: 215, green: 175, blue: 251, alpha: 1))
    }
    var logs: [String] = []
    var isAudit: Bool { return true }
    var begExc: UInt64 = 0
    var endExc: UInt64 = 0
    private let svgValuePattern = "(\")[a-zA-Z0-9+\\-\\(\\).,#& ]*(\")"
    var svgTextContent:String
    var beautifullSVGContents:String = ""
    var svgCode:NSAttributedString?
    
    mutating func beautifull() {
        svgCode = applyStyle(text: svgTextContent)
    }
    
    mutating func applyStyle(text:String) -> NSAttributedString? {
        let clock = QyClock(isTickWhenSleep: false)
        clock.startTick()
        do {
            if let attributed = try NSAttributedString.attribute(fromHTML: text) {
                clock.stopTick()
                print("\(#function) \(clock.log)")
                return attributed
            }
        }
        catch let e {
            print(e.localizedDescription)
        }
        clock.stopTick()
        print("\(#function) \(clock.log)")
        return nil
    }
}
