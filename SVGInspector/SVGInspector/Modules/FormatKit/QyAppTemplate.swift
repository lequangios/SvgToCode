//
//  QyAppTemplate.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

struct AppTheme {
    var primary:String = ""
    var primaryLight:String = ""
    var primaryDark:String = ""
    var second:String = ""
    var secondLight:String = ""
    var secondDark:String = ""
    var surface:String = ""
    var background:String = ""
    var error:String = ""
    var onPrimary:String = ""
    var onPrimaryLight:String = ""
    var onPrimaryDark:String = ""
    var onSecond:String = ""
    var onSecondLight:String = ""
    var onSecondDark:String = ""
    var onSurface:String = ""
    var onBackground:String = ""
    var onError:String = ""
    
    var iconToolbarSize:CGSize = .init(width: 30, height: 40)
    var dropdownToolbarSize:CGSize = .init(width: 80, height: 40)
    
    static let Indigo:AppTheme = .init(primary: "#3F51B5",
                                       primaryLight: "#7986CB",
                                       primaryDark: "#283593",
                                       second: "#5E35B1",
                                       secondLight: "#7E57C2",
                                       secondDark: "#6200EA",
                                       surface: "#536DFE",
                                       background: "#43A047",
                                       error: "#D84315",
                                       onPrimary: "#ffffff",
                                       onPrimaryLight: "#ffffff",
                                       onPrimaryDark: "#ffffff",
                                       onSecond: "#ffffff",
                                       onSecondLight: "#ffffff",
                                       onSecondDark: "#ffffff",
                                       onSurface: "#ffffff",
                                       onBackground: "#ffffff",
                                       onError: "#ffffff")
}


class QyAppTemplate {
    var codeFormatter:QySVGFomatterStyle
    var infoTag:QySVGLogTag
    var template:AppTheme
    init(codeFormatter:QySVGFomatterStyle, infoTag:QySVGLogTag, template:AppTheme) {
        self.codeFormatter = codeFormatter
        self.infoTag = infoTag
        self.template = template
    }
    static let xcode:QyAppTemplate = .init(codeFormatter: .xcode, infoTag: .bootstrap, template: .Indigo)
}

let Template = QyAppTemplate.xcode
