//
//  AppTheme.swift
//  SVG2Code
//
//  Created by Le Quang on 5/25/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

enum AppThemeName : Int {
    case Light
    case Dark
}

typealias AppBaseColor = (color1:NSColor, color2:NSColor, color3:NSColor, color4:NSColor)

protocol AppStyle {
    func mainbackground() -> NSColor
    func toolbarBackground() -> NSColor
    func toolbarTextColor() -> NSColor
    func loadingPlaceholderBackground() -> NSColor
    func spinerBackground() -> NSColor
    func colors() -> AppBaseColor
}

class DarkTheme:AppStyle {
    func colors() -> AppBaseColor {
        return (NSColor.init(red: 218, green: 133, blue: 65, alpha: 1), // Organce
                NSColor.init(red: 255, green: 184, blue: 65, alpha: 1), // Yellow
                NSColor.init(red: 54, green: 54, blue: 51, alpha: 1),   // Black
                NSColor.init(red: 154, green: 94, blue: 255, alpha: 1)) // Violet
    }
    
    func mainbackground() -> NSColor {
        return .black
    }
    
    func toolbarBackground() -> NSColor {
        return .black
    }
    
    func toolbarTextColor() -> NSColor {
        return .white
    }
    
    func loadingPlaceholderBackground() -> NSColor {
        return NSColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
    }
    
    func spinerBackground() -> NSColor {
        return .blue
    }
}



final class AppTheme: NSObject {
    static var shared = AppTheme()
    static var organce : NSColor {
        return AppTheme.shared.style.colors().color1
    }
    static var yellow : NSColor {
        return AppTheme.shared.style.colors().color2
    }
    static var black : NSColor {
        return AppTheme.shared.style.colors().color3
    }
    static var violet : NSColor {
        return AppTheme.shared.style.colors().color4
    }
    
    var style:AppStyle = DarkTheme()
    var appThemeName = AppThemeName.Dark {
        didSet {
            switch appThemeName {
            case .Dark:
                style = DarkTheme()
            default:
                style = DarkTheme()
            }
        }
    }
}

class AppTemplate {
    var codeFormatter:QySVGFomatterStyle
    var infoTag:QySVGLogTag
    init(codeFormatter:QySVGFomatterStyle, infoTag:QySVGLogTag) {
        self.codeFormatter = codeFormatter
        self.infoTag = infoTag
    }
    static let xcode:AppTemplate = .init(codeFormatter: .xcode, infoTag: .bootstrap)
}

let Template = AppTemplate.xcode

extension String {
    static var tab:String = "&emsp;"
    var rightSpace:String { return "\(self) " }
    var quote:String { return "\"\(self)\"" }
    var style:String { return "style=\"\(self)\"" }
    var box:String { return "<div \(Template.codeFormatter.blockStyle.style)>\(self)</div>" }
    var `operator`:String { return "<span \(Template.codeFormatter.operactorStyle.style)><b>\(self)</b></span>" }
    var tag:String {
        let css = "\(Template.codeFormatter.font)\(Template.codeFormatter.tagStyle)"
        return "<span \(css.style)>\(self.rightSpace)</span>"
    }
    var attribute:String { return "<span \(Template.codeFormatter.attributeStyle.style)>\(self)</span>" }
    var attributeValue:String { return "<span \(Template.codeFormatter.attributeValueStyle.style)>\(self.rightSpace)</span>"}
    var keyword:String { return "<span \(Template.codeFormatter.keywordStyle.style)><b>\(self)</b></span>" }
    var content:String { return "<span \(Template.codeFormatter.contentValueStyle.style)>\(self)</span>" }
    
    func line(withTab tab:Int) -> String {
        //let css = "\(Template.codeFormatter.lineStyle )\(Template.codeFormatter.left(tab: tab))"
        let css = "\(Template.codeFormatter.lineStyle )"
        let t = String(repeating: String.tab, count: tab)
        return "<p \(css.style)>\(t)\(self)</p>"
    }
    
    func line(withTap tab:Int, lineNumber:Int) -> String {
        return "<p \(Template.codeFormatter.lineStyle.style)><span \(Template.codeFormatter.lineNumberStyle.style)>\(lineNumber)<span><span \(Template.codeFormatter.left(tab: tab).style)>\(self)</span><p>"
    }
}

extension Dictionary where Key == String, Value == String {
    func joined() -> String {
        var value = ""
        for data in self.enumerated() {
            value += "\(data.element.key.attribute)\("=".operator)\(data.element.value.quote.attributeValue)"
        }
        return value
    }
}



