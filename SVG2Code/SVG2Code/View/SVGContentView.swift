//
//  SVGContentView.swift
//  SVG2Code
//
//  Created by Le Quang on 6/30/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

class SVGContentView: NSTextView {
    // MARK: - View Update
    func updateModel(model:QySVGCode) {
        if let attr = model.svgCode {
            self.textStorage?.setAttributedString(attr)
        }
        
    }
}
