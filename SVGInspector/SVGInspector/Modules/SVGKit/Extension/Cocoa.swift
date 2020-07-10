//
//  Cocoa.swift
//  SVG2Code
//
//  Created by Le Quang on 6/14/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension NSColor {
    func with(alpha:NSNumber) -> NSColor {
        return NSColor.init(red: redComponent, green: redComponent, blue: blueComponent, alpha: CGFloat(alpha.doubleValue))
    }
}
