//
//  NSView+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/9/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

//MARK: - Basic Method for View
extension NSView {
    var isUseAutoLayout:Bool { return translatesAutoresizingMaskIntoConstraints }
    
    var center:CGPoint {
        return CGPoint(x: (frame.origin.x + frame.size.width/2), y: (frame.origin.y + frame.size.height/2))
    }
    
    var width:CGFloat {
        get {
            return frame.size.width
        }
        set { frame = CGRect(origin: frame.origin, size: CGSize(width: newValue, height: frame.size.height)) }
    }
    
    var height:CGFloat {
        get { return frame.size.height }
        set { frame = CGRect(origin: frame.origin, size: CGSize(width: frame.size.height, height: newValue)) }
    }
    
    var x:CGFloat {
        get { return frame.origin.x }
        set { frame = CGRect(origin: CGPoint(x: newValue, y: frame.origin.y), size: frame.size) }
    }
    
    var y:CGFloat {
        get { return frame.origin.y }
        set { frame = CGRect(origin: CGPoint(x: frame.origin.x, y: newValue), size: frame.size) }
    }
    
    var backgroundColor : NSColor? {
        get {
            if let cgColor = layer?.backgroundColor { return NSColor(cgColor: cgColor) }
            return nil
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
    
    func allowUpdateLayer(){
        layerContentsRedrawPolicy = .onSetNeedsDisplay
        canDrawSubviewsIntoLayer = false
    }
    
    func addSubLayer(_ layer:CAShapeLayer) {
        self.wantsLayer = true
        self.layer?.addSublayer(layer)
    }
    
    func addSubLayer(_ layer:CALayer?) {
        if let newlayer = layer {
            self.wantsLayer = true
            self.layer?.addSublayer(newlayer)
        }
    }
    
    func sendSubview(toBack view:NSView) {
        let keepView = view
        let constraint = view.constraints
        view.removeConstraints(view.constraints)
        view.removeFromSuperview()
        self.addSubview(keepView, positioned: .below, relativeTo: nil)
        keepView.addConstraints(constraint)
    }
    
    func bringSubview(toFront view:NSView) {
        let keepView = view
        let constraint = view.constraints
        view.removeConstraints(view.constraints)
        view.removeFromSuperview()
        self.addSubview(keepView, positioned: .above, relativeTo: nil)
        keepView.addConstraints(constraint)
    }
    
    func makeFrame(centerIn view: NSView){
        frame.origin = CGPoint(x: view.x + (view.width - width)/2, y: view.y + (view.height - height)/2)
    }
}

//MARK: - Method for View Animation when Change Content
extension NSObject.Object {
    static var kIsUseAnimationLayerChange:UInt8 = 0
    static var kInLayer:UInt8 = 0
    static var kOutLayer:UInt8 = 0
}

extension NSView {
    var oldLayer:CALayer? {
        get {
            if let oldlayer = objc_getAssociatedObject(self, &(NSObject.Object.kOutLayer)) as? CALayer {
                return oldlayer
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &(NSObject.Object.kOutLayer), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var newLayer:CALayer? {
        get {
            if let newLayer = objc_getAssociatedObject(self, &(NSObject.Object.kInLayer)) as? CALayer {
                return newLayer
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &(NSObject.Object.kInLayer), newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func replaceOldLayer(byNewLayer layerItem:CALayer, transition:CATransition = .push) {
        if state != NSObject.State.loading { return }
        if let old = oldLayer {
            transition.delegate = self
            old.add(transition, forKey: "transition")
            layer?.insertSublayer(layerItem, below: old)
            old.isHidden = true
            newLayer = layerItem
            state = .loading
        }
        else {
            layerItem.isHidden = true
            layerItem.add(transition, forKey: "transition")
            layer?.insertSublayer(layerItem, below: nil)
            layerItem.isHidden = false
            oldLayer = layerItem
            state = .loading
        }
    }
}

extension NSView : CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        state = .normal
        if let old = oldLayer, flag == true {
            old.removeAllAnimations()
            old.removeFromSuperlayer()
            oldLayer = newLayer
        }
    }
}

