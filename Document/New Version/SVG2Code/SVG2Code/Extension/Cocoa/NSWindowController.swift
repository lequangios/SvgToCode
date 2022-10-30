//
//  NSWindowController.swift
//  SVG2Code
//
//  Created by Le Quang on 5/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension NSWindowController {
    func toggleLoadingSpiner() {
        if let content = contentViewController {
            content.toggleLoadingSpiner()
        }
    }
}
