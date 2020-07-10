//
//  SVGPreviewModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/26/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa
import CoreGraphics

class SVGPreviewModel {
    var layer:CALayer
    var layerList:[String:CALayer]
    var size:CGSize
    var forcusLayerName:String = ""
    var code:QySVGCode?
    
    init() {
        self.layer = CALayer()
        self.layerList = [:]
        self.size = .zero
    }
    
    init(layer:CALayer, layerList:[String:CALayer], size:CGSize) {
        self.layer = layer
        self.layerList = layerList
        self.size = size
    }
    
    deinit {
        layer.removeAllAnimations()
        layer.removeFromSuperlayer()
        layerList.removeAll()
    }
}
