//
//  MainWindowController.swift
//  SVGInspector
//
//  Created by Le Quang on 7/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

class MainWindowController : NSWindowController {
    var addSVGAction:Selector?
    var programmingNameSelected:Selector?
    var saveCodeAction:Selector?
    //MARK: - Outlet
    @IBOutlet weak var mainToolbar: NSToolbar!
    @IBOutlet weak var selectProgramNameBarItem: NSPopUpButton!
    @IBOutlet weak var addNewSVGBarItem: NSButtonCell!
    @IBOutlet weak var saveCodeBarItem: NSButtonCell!
    
    //MARK: - Life Cicyle
    override func windowDidLoad() {
        super.windowDidLoad()
        initiateUI()
    }
    
    func initiateUI() {
        window?.title = "SVG Inspector".localized
        window?.backgroundColor = Template.template.onPrimaryDark.colorValue
    }
}

// MARK: - Window Controller With NSToolbarDelegate
extension MainWindowController : NSToolbarDelegate {
    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == NSToolbarItem.Identifier.addSVG {
            if let toolbarItem = NSToolbarItem.createToolbarItem(withIdentifier: NSToolbarItem.Identifier.addSVG.rawValue,
                                                                 label: "Add SVG".localized,
                                                                 paletteLabel: "Add SVG".localized,
                                                                 toolTip: "Add SVG".localized,
                                                                 itemContent: addNewSVGBarItem) {
                toolbarItem.maxSize = Template.template.iconToolbarSize
                toolbarItem.addToolbarItemAction(withSelector: addSVGAction, target: self)
                return toolbarItem
            }
        } else if itemIdentifier == NSToolbarItem.Identifier.programmingname {
            if let toolbarItem = NSToolbarItem.createToolbarItem(withIdentifier: NSToolbarItem.Identifier.addSVG.rawValue,
                                                                 label: "Programming Language".localized,
                                                                 paletteLabel: "Select Programming Language".localized,
                                                                 toolTip: "Select Programming Language".localized,
                                                                 itemContent: selectProgramNameBarItem) {
                toolbarItem.maxSize = Template.template.dropdownToolbarSize
                toolbarItem.addToolbarItemAction(withSelector: programmingNameSelected, target: self)
                return toolbarItem
            }
        }
        else if itemIdentifier == NSToolbarItem.Identifier.savecode {
            if let toolbarItem = NSToolbarItem.createToolbarItem(withIdentifier: NSToolbarItem.Identifier.addSVG.rawValue,
                                                                 label: "Save Code".localized,
                                                                 paletteLabel: "Save Code".localized,
                                                                 toolTip: "Save Code".localized,
                                                                 itemContent: saveCodeBarItem) {
                toolbarItem.maxSize = Template.template.iconToolbarSize
                toolbarItem.addToolbarItemAction(withSelector: saveCodeAction, target: self)
                return toolbarItem
            }
        }
        return NSToolbarItem.init(itemIdentifier: itemIdentifier)
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.addSVG, .flexibleSpace, .savecode, .programmingname]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [ NSToolbarItem.Identifier.addSVG,
                 NSToolbarItem.Identifier.savecode,
                 NSToolbarItem.Identifier.flexibleSpace,
                 NSToolbarItem.Identifier.programmingname
        ]
    }
}
