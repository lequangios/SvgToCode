//
//  ViewModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/26/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

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
    func toogleProccessingView(event:MBObserver.DataEvent)
    func toogleErrorView(error:Error, event:MBObserver.DataEvent)
}

extension MBObserver.DataEvent {
    static let modelChange:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.modelchange")
    static let svgTextContentChange:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.svgtextcontentchange")
    static let svgLanguageNameChange:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.modelchange")
    static let svgTreeModelChange:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.svgtreemodelchange")
    static let dataProcessingBegin:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.dataprocessingbegin")
    static let dataProcessingEnd:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.dataprocessingend")
    static let svgCodeChange:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.svgcodechange")
    static let svgPreviewChange:MBObserver.DataEvent = .init(key: "", value: "com.mobilecodelab.svgpreviewchange")
}

class ViewModel: MBObserver {
    var key:DataKey = .code
    var view:ViewDataBinding?
    var dataEvent:[DataEvent] = []
    var observers:[MBObserver.Observer] = []
    
    init(view:ViewDataBinding) {
        self.view = view
    }
    
    func renderProccessingView(keyPath: String, dataEvent:DataEvent){
        if let viewObj = view {
            DispatchQueue.global(qos: .userInteractive).sync {
                viewObj.toogleProccessingView(event: dataEvent)
            }
        }
    }
    
    func renderView(keyPath: String, data:Result<ViewModel,Error>, dataEvent:DataEvent){
        
    }
    
    func updateView(keyPath: String, data:Result<ViewModel,Error>?, dataEvent:DataEvent){
        if let viewObj = view {
            DispatchQueue.global(qos: .userInteractive).sync {
                viewObj.toogleProccessingView(event: dataEvent)
            }
        }
    }
    
    func renderFailView(keyPath: String, error:Error, dataEvent:DataEvent) {
        if let viewObj = view {
            DispatchQueue.global(qos: .userInteractive).sync {
                viewObj.toogleErrorView(error: error, event: dataEvent)
            }
        }
    }
    
    func renderSuccessView(keyPath: String, data:ViewModel, dataEvent:DataEvent) {
        
    }
    
    func addObserver() {
        for var ob in observers {
            add(observer: &ob)
        }
    }
    
    func removeObserver() {
        for var ob in observers {
            remove(observer: &ob)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {}
    
    deinit {
        removeObserver()
    }
}
