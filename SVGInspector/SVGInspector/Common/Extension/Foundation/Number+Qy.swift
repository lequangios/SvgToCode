//
//  Number+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/9/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

//MARK: - Int with QySVGFomatterStyle + QyAppTemplate
extension Int {
    var line:String { return "<span \(Template.codeFormatter.lineStyle.style)>\(self)</span>"}
}
