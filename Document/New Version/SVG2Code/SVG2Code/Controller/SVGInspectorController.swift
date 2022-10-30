//
//  SVGInspectorController.swift
//  SVG2Code
//
//  Created by Le Quang on 5/17/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa
import CoreImage

class SVGInspectorController: NSViewController {
    // MARK: - View Controller Life Cycle
    var model:SVGPreviewModel! {
        didSet {
            refresh()
        }
    }
    
    private var svgLayer:CALayer?
    
    @IBOutlet weak var svgPreview: NSClipView!
//    @IBOutlet var svgContentFile: NSTextView!
    
    @IBOutlet var svgContentFile: SVGContentView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addDataListener()
        setupUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func setupUI() {
        if let svgView = svgPreview.documentView as? SVGPreviewView {
            svgView.toggleTimer()
        }
    }
    
    deinit {
        
    }
}

// MARK: - View Controller Data Binding
extension SVGInspectorController {
    func refresh() {
        print("SVGInspectorController refresh")
        
        if let svgView = svgPreview.documentView as? SVGPreviewView {
            svgView.updateModel(svgModel: model)
            model.code?.beautifull()
            if let code = model.code?.svgCode {
                svgContentFile.textStorage?.setAttributedString(code)
            }
        }
        
        self.view.layoutSubtreeIfNeeded()
    }
    
    @objc func map(notification: NSNotification){
        if let data = notification.userInfo as? [String:Any] {
            if let model = data["model"] as? SVGPreviewModel {
                self.model = model
            }
            else if let error = data["error"] as? Error {
                toggleAlertInformation(with: error as NSError)
            }
        }
    }

    
    func addDataListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(map(notification:)), name: MBObserver.DataEvent.svgPreviewChange.notification, object: nil)
    }
    
   
}

