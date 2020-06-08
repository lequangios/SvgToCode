//
//  ViewController.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    // MARK: - View Controller Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupUI(){
        
    }
}

// MARK: - Window Controller With MainViewModel
extension MainViewController : MainViewDataBinding {
    func syns(tree data: SVGTreeModel?, error: Error?, dataEvent: DataEvent) {
        
    }
    
    func syns(preview data: SVGPreviewModel?, error: Error?, dataEvent: DataEvent) {
        if let model = data, dataEvent == .svgPreviewChange {
            NotificationCenter.default.post(name: dataEvent.notification(), object: nil, userInfo: ["model":model])
        }
    }
    
    func syns(code data: String?, error: Error?, dataEvent: DataEvent) {
        if let code = data, dataEvent == .svgCodeChange {
            NotificationCenter.default.post(name: dataEvent.notification(), object: nil, userInfo: ["code":code])
        }
    }
    
    func toogleProccessingView(event: DataEvent) {
        if event == .modelChange {
            NotificationCenter.default.post(name: event.notification(), object: nil)
        }
    }
    
    func toogleErrorView(error: Error, event: DataEvent) {
        if event == .modelChange {
            toggleAlertInformation(with: error as NSError)
        }
        else if event == .svgPreviewChange {
            NotificationCenter.default.post(name: event.notification(), object: nil, userInfo: ["error":error])
        }
        else if event == .svgCodeChange {
            NotificationCenter.default.post(name: event.notification(), object: nil, userInfo: ["error":error])
        }
    }
    
   
}


