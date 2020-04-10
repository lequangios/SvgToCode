//
//  NSView+SVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/7/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa

extension NSView {
    func setBackgroundColor(_ color:NSColor = NSColor.blue){
        self.wantsLayer = true
        self.layer?.backgroundColor = color.cgColor
    }
    
}
