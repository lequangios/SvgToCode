//
//  ViewModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/26/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static var modelChange = Notification.Name(DataEvent.modelChange.rawValue)
    static var dataProcessingBegin = Notification.Name(DataEvent.dataProcessingBegin.rawValue)
    static var dataProcessingEnd = Notification.Name(DataEvent.dataProcessingEnd.rawValue)
}

extension Result where Success:ViewModel {
    func covert()->(data:ViewModel?, error:Error?) {
        switch self {
        case .success(let model):
            return (model, nil)
        case .failure(let error):
            return (nil, error)
        }
    }
}

protocol ViewDataBinding {
    func toogleProccessingView(event:DataEvent)
    func toogleErrorView(error:Error, event:DataEvent)
}

enum DataEvent: String {
    case modelChange            = "com.mobilecodelab.modelchange"
    case svgTextContentChange   = "com.mobilecodelab.svgtextcontentchange"
    case svgLanguageNameChange  = "com.mobilecodelab.svglanguagenamechange"
    case svgTreeModelChange     = "com.mobilecodelab.svgtreemodelchange"
    case dataProcessingBegin    = "com.mobilecodelab.dataprocessingbegin"
    case dataProcessingEnd      = "com.mobilecodelab.dataprocessingend"
    case svgCodeChange          = "com.mobilecodelab.svgcodechange"
    case svgPreviewChange       = "com.mobilecodelab.svgpreviewchange"
    
    func notification() -> Notification.Name {
        return Notification.Name.init(self.rawValue)
    }
}

class ViewModel: NSObject {    
    var view:ViewDataBinding?
    var dataEvent:DataEvent = .modelChange
    
    init(view:ViewDataBinding) {
        self.view = view
    }
    
    func renderProccessingView(keyPath: String, dataEvent:DataEvent){
        if let viewObj = view {
            viewObj.toogleProccessingView(event: dataEvent)
        }
    }
    
    func renderView(keyPath: String, data:Result<ViewModel,Error>, dataEvent:DataEvent){
        
    }
    
    func updateView(keyPath: String, data:Result<ViewModel,Error>?, dataEvent:DataEvent){
        if let viewObj = view {
            viewObj.toogleProccessingView(event: dataEvent)
        }
    }
    
    func renderFailView(keyPath: String, error:Error, dataEvent:DataEvent) {
        if let viewObj = view {
            viewObj.toogleErrorView(error: error, event: dataEvent)
        }
    }
    
    func renderSuccessView(keyPath: String, data:ViewModel, dataEvent:DataEvent) {
        
    }
    
    func addObserver() {
        
    }
    
    func removeObserver() {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
    
    deinit {
        removeObserver()
    }
}
