//
//  NSView+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

struct NSViewAssociatedKey {
    static var kOldLayerKey:UInt8 = 0
    static var kNewLayerKey:UInt8 = 0
}

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
    
    func constraints(centerIn view: NSView){
        
    }
    
    func constraintsForAnchoringTo(centerOf view: NSView) -> [NSLayoutConstraint] {
        let centerVertically = NSLayoutConstraint(item: self,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                     toItem: view,
                                                  attribute: .centerX,
                                                 multiplier: 1.0,
                                                   constant: 0.0)
        let centerHorizontally = NSLayoutConstraint(item: self,
                                               attribute: .centerY,
                                               relatedBy: .equal,
                                                  toItem: view,
                                               attribute: .centerY,
                                              multiplier: 1.0,
                                                constant: 0.0)
        
        return [
            centerVertically, centerHorizontally
        ]
    }
    
    func top(toView view:NSView, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0, related:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: related, toItem: view, attribute: .top, multiplier: multiplier, constant: constant)
    }
    
    func bottom(toView view:NSView, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0, related:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: related, toItem: view, attribute: .bottom, multiplier: multiplier, constant: constant)
    }
    
    func leading(toView view:NSView, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0, related:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .leading, relatedBy: related, toItem: view, attribute: .leading, multiplier: multiplier, constant: constant)
    }
    
    func trailing(toView view:NSView, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0, related:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: related, toItem: view, attribute: .trailing, multiplier: multiplier, constant: constant)
    }
}

//MARK: Extension For UI Animation
extension NSView {
    var oldLayer:CALayer? {
        get {
            if let oldlayer = objc_getAssociatedObject(self, &NSViewAssociatedKey.kOldLayerKey) as? CALayer {
                return oldlayer
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &NSViewAssociatedKey.kOldLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var newLayer:CALayer? {
        get {
            if let newLayer = objc_getAssociatedObject(self, &NSViewAssociatedKey.kNewLayerKey) as? CALayer {
                return newLayer
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &NSViewAssociatedKey.kNewLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func replaceOldLayer(byNewLayer layerItem:CALayer) {
        let transition = CATransition()
        transition.duration = 2
        transition.type = CATransitionType.push
        
        if let old = oldLayer {
            transition.delegate = self
            old.add(transition, forKey: "transition")
            layer?.insertSublayer(layerItem, below: old)
            old.isHidden = true
            newLayer = layerItem
        }
        else {
            layerItem.isHidden = true
            layerItem.add(transition, forKey: "transition")
            layer?.insertSublayer(layerItem, below: nil)
            layerItem.isHidden = false
            oldLayer = layerItem
        }
    }
}

extension NSView : CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let old = oldLayer, flag == true {
            old.removeAllAnimations()
            old.removeFromSuperlayer()
            oldLayer = newLayer
        }
    }
}

