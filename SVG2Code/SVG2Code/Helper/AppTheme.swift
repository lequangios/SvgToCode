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
