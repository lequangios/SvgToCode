//
//  NSViewController+App.swift
//  SVG2Code
//
//  Created by Le Quang on 5/21/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

private var kNSViewControllerLoading: UInt8 = 0
private var kNSViewControllerHadLoading: UInt8 = 0

private var kNSViewControllerLoadingPlacehoder: UInt8 = 0
private var kNSViewControllerHadLoadingPlacehoder: UInt8 = 0

extension NSViewController {@objc 
    var isHadLoadingSpinerPlacehoder:Bool {
        get {
            if let flag = objc_getAssociatedObject(self, &kNSViewControllerHadLoadingPlacehoder) as? Bool {
                return flag
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &kNSViewControllerHadLoadingPlacehoder, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var isHadLoadingSpiner:Bool {
        get {
            if let flag = objc_getAssociatedObject(self, &kNSViewControllerHadLoading) as? Bool {
                return flag
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &kNSViewControllerHadLoading, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var loadingSpiner:NSProgressIndicator? {
        get {
            if let spiner = objc_getAssociatedObject(self, &kNSViewControllerLoading) as? NSProgressIndicator {
                return spiner
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &kNSViewControllerLoading, newValue, .OBJC_ASSOCIATION_RETAIN)
            if newValue != nil { isHadLoadingSpiner = true }
        }
    }
    
    var loadingSpinerPlacehodler:NSView? {
        get {
            if let spiner = objc_getAssociatedObject(self, &kNSViewControllerLoadingPlacehoder) as? NSView {
                return spiner
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &kNSViewControllerLoadingPlacehoder, newValue, .OBJC_ASSOCIATION_RETAIN)
            if newValue != nil { isHadLoadingSpinerPlacehoder = true }
        }
    }
    
    func createLoading(spiner:NSProgressIndicator, placeholder:NSView? = nil) {
        if let placeholaderView = placeholder {
            placeholaderView.addSubview(spiner)
            placeholaderView.isHidden = true
            if isHadLoadingSpinerPlacehoder == false {
                view.addSubview(placeholaderView, positioned: .below, relativeTo: view)
            }
            
            if isHadLoadingSpiner == true { loadingSpiner?.removeFromSuperview() }
            loadingSpinerPlacehodler = placeholaderView
            loadingSpiner = spiner
        }
        else {
            spiner.isHidden = true
            if isHadLoadingSpiner == false {
                view.addSubview(spiner, positioned: .below, relativeTo: view)
            }
            loadingSpiner = spiner
        }
    }
    
    func layoutLoading(){
        if let placeholaderView = loadingSpinerPlacehodler {
            placeholaderView.frame.size = view.frame.size
            loadingSpiner?.makeFrame(centerIn: placeholaderView)
        }
        else {
            loadingSpiner?.makeFrame(centerIn: view)
        }
    }
    
    func toggleLoadingSpiner(){
        if let placeholaderView = loadingSpinerPlacehodler {
            if placeholaderView.isHidden == true {
                placeholaderView.isHidden = false
                loadingSpiner?.startAnimation(self)
                view.bringSubview(toFront: placeholaderView)
            }
            else {
                placeholaderView.isHidden = true
                loadingSpiner?.stopAnimation(self)
                view.sendSubview(toBack: placeholaderView)
            }
        }
        else if let loading = loadingSpiner {
            if loading.isHidden == true {
                loading.isHidden = false
                loading.startAnimation(self)
            }
            else {
                loading.isHidden = true
                loading.stopAnimation(self)
            }
        }
    }
    
    func toggleAlertInformation(with error:NSError){
        let alert = NSAlert()
        alert.messageText = error.message
        alert.informativeText = error.failureReason
        alert.alertStyle = .warning
        alert.icon = NSImage(named: "svgicon")
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    func toggleAlertInformation(with error:Error){
        let alert = NSAlert()
        alert.messageText = error.message
        alert.informativeText = error.failureReason
        alert.alertStyle = .warning
        alert.icon = NSImage(named: "svgicon")
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

//MARK: - Hanlder loading spiner for MainViewModel
extension NSViewController {
    @objc func loading() {
        toggleLoadingSpiner()
    }
    
    func addLoadingListener(event:DataEvent){
        NotificationCenter.default.addObserver(self, selector: #selector(loading), name: event.notification(), object: nil)
    }
    
    func removeLoadingListener(event:DataEvent){
        NotificationCenter.default.removeObserver(self, name: event.notification(), object: nil)
    }
}

//MARK: - Use for add to NSSplitViewController
extension NSViewController {
    var splitViewItemName:String { return "NSViewController" }
    func updateViewConstraint() {}
}
