//
//  MainWindowController.swift
//  SVG2Code
//
//  Created by Le Quang on 5/17/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Cocoa

class MainWindowController : NSWindowController {
    // MARK: - Model Data
    var model:MainViewModel!
    
    // MARK: - Window Controller Properties
    @IBOutlet var mainToolBar: NSToolbar!
    //@IBOutlet var selectProgramNameBarItem: NSView!
    @IBOutlet weak var selectProgramNameBarItem: NSPopUpButton!
    @IBOutlet weak var addNewSVGBarItem: NSButtonCell!
    @IBOutlet var saveCodeBarItem: NSButton!
    
    // MARK: - Window Controller Life Cycle
    override func windowDidLoad() {
        super.windowDidLoad()
        if let content = self.contentViewController as? ViewDataBinding {
            model = MainViewModel(view: content)
            model.addObserver()
        }
        updateLangSelect(selectProgramNameBarItem)
    }
    
    
    // MARK: - Window Controller UI Configure
    private func configureToolBar() {
        mainToolBar.allowsUserCustomization = true
        mainToolBar.autosavesConfiguration = true
        mainToolBar.displayMode = .iconOnly
    }
    
    private func updateLangSelect(_ popup:NSPopUpButton, ele:LanguageName = .Obj){
        for name in ele.all() {
            popup.addItem(withTitle: name.rawValue)
        }
    }
    
    // MARK: - Window Controller Button Action
    @objc
    func openSVGFile(sender:AnyObject?) {
        let openPanel = NSOpenPanel()
        openPanel.allowedFileTypes = ["svg"]
        openPanel.begin { [weak self](result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                if let filename = openPanel.url {
                    do {
                        let string = try NSString.init(contentsOf: filename, encoding: String.Encoding.utf8.rawValue)
                        self?.model.svgTextContent = string as String
                   } catch let e as NSError {
                        if let obj = self {
                            obj.contentViewController?.toggleAlertInformation(with: e)
                        }
                    
                   }
                }
                
            } else {
                __NSBeep()
            }
        }
    }
    
    @objc func saveCodeToFile(sender:AnyObject?) {
        if let language = LanguageName(rawValue: model.svgCodeLange), let code = model.svgCode {
            let mySave = NSSavePanel()
            mySave.allowedFileTypes = language.allowFiles()
            mySave.begin { (result) -> Void in
                if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    let filename = mySave.url
                    
                    do {
                        try code.write(to: filename!, atomically: true, encoding: String.Encoding.utf8)
                    } catch let e as NSError {
                        self.contentViewController?.toggleAlertInformation(with: e)
                    }
                    
                } else {
                    __NSBeep()
                }
            }
        }
    }
    
    deinit {
        model.removeObserver()
    }
}

// MARK: - Window Controller With NSToolbarDelegate
extension MainWindowController : NSToolbarDelegate {
    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == NSToolbarItem.Identifier.addSVG {
            let toolbarItem = NSToolbarItem.createCustomBarItem(itemForItemIdentifier: NSToolbarItem.Identifier.addSVG.rawValue, label: "Add SVG", paletteLabel: "Add SVG", toolTip: "Add SVG", itemContent: addNewSVGBarItem)
            toolbarItem?.maxSize = CGSize.init(width: 30, height: 30)
            toolbarItem?.add(action: #selector(MainWindowController.openSVGFile(sender:)), target: self)
            return toolbarItem
            
        } else if itemIdentifier == NSToolbarItem.Identifier.programmingname {
            let toolbarItem = NSToolbarItem.createCustomBarItem(itemForItemIdentifier: NSToolbarItem.Identifier.addSVG.rawValue, label: "Programming Language", paletteLabel: "Select Programming Language", toolTip: "Select Programming Language", itemContent: selectProgramNameBarItem)
            toolbarItem?.maxSize = CGSize.init(width: 80, height: 30)
            return toolbarItem
        }
        else if itemIdentifier == NSToolbarItem.Identifier.savecode {
            let toolbarItem = NSToolbarItem.createCustomBarItem(itemForItemIdentifier: NSToolbarItem.Identifier.addSVG.rawValue, label: "Save Code", paletteLabel: "Save Code", toolTip: "Save Code", itemContent: saveCodeBarItem)
            toolbarItem?.maxSize = CGSize.init(width: 30, height: 30)
            toolbarItem?.add(action: #selector(MainWindowController.saveCodeToFile(sender:)), target: self)
            return toolbarItem
        }
        else {
            return NSToolbarItem.init(itemIdentifier: itemIdentifier)
        }
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
