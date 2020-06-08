//
//  NSToolbarItem+App.swift
//  SVG2Code
//
//  Created by Le Quang on 5/17/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa

extension NSToolbarItem.Identifier {
    static let addSVG = NSToolbarItem.Identifier.init(rawValue: "com.mobilecodelab.addsvg")
    static let programmingname = NSToolbarItem.Identifier.init(rawValue: "com.mobilecodelab.programmingname")
    static let savecode = NSToolbarItem.Identifier.init(rawValue: "com.mobilecodelab.savecode")
}

extension NSToolbarItem {
    static func createCustomBarItem(itemForItemIdentifier itemIdentifier: String, label: String, paletteLabel: String, toolTip: String, itemContent: AnyObject) -> NSToolbarItem? {
        let toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: itemIdentifier))
        
        toolbarItem.label = label
        toolbarItem.paletteLabel = paletteLabel
        toolbarItem.toolTip = toolTip
        toolbarItem.target = self
        
        // Set the right attribute, depending on if we were given an image or a view.
        if itemContent is NSImage {
            if let image = itemContent as? NSImage {
                toolbarItem.image = image
            }
        } else if itemContent is NSView {
            if let view = itemContent as? NSView {
                toolbarItem.view = view
            }
        } else if itemContent is NSButtonCell {
            if let view = itemContent as? NSButtonCell {
                toolbarItem.view = view.controlView
            }
        }
        else {
            assertionFailure("Invalid itemContent: object")
        }
        
        // We actually need an NSMenuItem here, so we construct one.
        let menuItem: NSMenuItem = NSMenuItem()
        menuItem.submenu = nil
        menuItem.title = label
        toolbarItem.menuFormRepresentation = menuItem
        
        return toolbarItem
    }
    
    func add(action selector:Selector?, target:AnyObject?) {
        self.action = selector
        self.target = target
    }
}
