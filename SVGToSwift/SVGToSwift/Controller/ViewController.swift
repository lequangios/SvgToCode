//
//  ViewController.swift
//  SVGToSwift
//
//  Created by Le Viet Quang on 9/16/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    private var isXML:Bool = true
    
    @IBOutlet weak var inputText: NSTextField!
    
    @IBOutlet weak var namePath: NSTextField!
    
    @IBOutlet weak var outputText: NSTextField!
    
    @IBOutlet weak var labelText: NSTextField!
    
    @IBOutlet weak var saveTIToFile: NSButton!
    
    @IBAction func saveNow(_ sender: NSButton) {
        let data = outputText.stringValue
        if data != "" {
            let mySave = NSSavePanel()
            mySave.allowedFileTypes = ["txt"]
            
            mySave.begin { (result) -> Void in
                
                if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    let filename = mySave.url
                    
                    do {
                        try data.write(to: filename!, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        // failed to write file (bad permissions, bad filename etc.)
                    }
                    
                } else {
                    __NSBeep()
                }
            }
        }
    }
    
    @IBAction func indexChanged(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            isXML = false
            labelText.stringValue = "From Path value"
            break
        default:
            isXML = true
            labelText.stringValue = "Parse from xml"
            break
        }
    }
    
    
    //@IBOutlet weak var svgView: NSView!
    
    
    @IBAction func convert2Swift(_ sender: Any) {
        let input = inputText.stringValue
        let name = namePath.stringValue
        
        if isXML == false {
            let text = String.getCode(svgPath: input, name: name)
            outputText.stringValue = text
            outputText.cell?.wraps = true
        }
        else {
            let manager = SVGXMLManager.init(input, name: name)
            outputText.stringValue = manager.code
            outputText.cell?.wraps = true
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let svg = NSView.init(SVGURL: URL.init(string: "https://s.cdpn.io/3/kiwi.svg")!)
//        svg.frame = svgView.bounds
//        svgView.addSubview(svg)
//        print(SVGText.shared.getText())
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

