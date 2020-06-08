//
//  SVGPreviewView.swift
//  SVG2Code
//
//  Created by Le Quang on 5/31/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

@objc protocol SVGPreviewDelegate {
    @objc optional func didSelected(withLayer layer:CAShapeLayer)
}

class SVGPreviewView: NSView {
    var layerList:[String:CALayer] = [:]
    var point:CGPoint = .zero
    var trackingArea : NSTrackingArea?
    private var timer:Timer?
    
    override var wantsUpdateLayer:Bool{
        return true
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea!)
        }
        let options : NSTrackingArea.Options =
            [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow]
        trackingArea = NSTrackingArea(rect: self.bounds, options: options,
                                      owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
    
    override func updateLayer() {
        super.updateLayer()
        if layerList.keys.count == 0 {
            return
        }
        for key in layerList.keys {
            if let value = layerList[key] as? CAShapeLayer {
                if let p = self.layer?.convert(point, to: value){
                    value.check(contain: p)
                }
                if value.isfocus > 0 {
                    value.apply(alpha: 0.2)
                    print("isfocus \(value.name ?? "")")
                }
                else {
                    value.apply(alpha: 1)
                }
            }
        }
    }
    
    // MARK: - View Update
    public func updateModel(svgModel model:SVGPreviewModel) {
        // Stop Timer
        if timer?.isValid == true {
            timer?.invalidate()
        }
        layerList.removeAll()
        layerList = model.layerList
        // Update Size of layer
        frame.size = model.size
        layer?.bounds = CGRect(origin: .zero, size: model.size)
        // Update Track
        updateTrackingAreas()
        // Update layer
        replaceOldLayer(byNewLayer: model.layer)
        // Start timer
        toggleTimer()
    }
    
    public func toggleTimer() {
        if timer?.isValid == true {
            timer?.invalidate()
        }
        else {
            timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateSVGTree), userInfo: nil, repeats: true)
            
        }
    }
   
    @objc func updateSVGTree() {
        updateLayer()
    }
    
    // MARK: - View Mouse Hanlder
    
    override func mouseMoved(with event: NSEvent) {
        if let curPoint = layer?.convert(event.locationInWindow, to: nil) {
            point = curPoint
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if let curPoint = layer?.convert(event.locationInWindow, to: nil) {
            point = curPoint
        }
    }
    
    override func cursorUpdate(with event: NSEvent) {
        NSCursor.pointingHand.set()
    }
    
    deinit {
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea!)
        }
        
        timer?.invalidate()
    }
}
