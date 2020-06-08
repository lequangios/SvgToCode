//
//  PreviewController.swift
//  SVGToSwift
//
//  Created by Le Quang on 5/1/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa

class PreviewController: NSViewController {
    var model:ReviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        let layer = model.makeShapeLayer()
        view.addSubLayer(layer)
    }
    
    override var representedObject: Any? {
        didSet {
            if let data = representedObject as? ReviewViewModel {
                model = data
            }
        }
    }
}
