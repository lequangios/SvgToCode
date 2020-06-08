//
//  ViewModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/26/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension Notification.Name {
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
    func svgTreeUpdate(data:ViewModel?, error:Error?, dataEvent:DataEvent)
    func svgCodeUpdate(data:ViewModel?, error:Error?, dataEvent:DataEvent)
    func svgPreviewUpdate(data:ViewModel?, error:Error?, dataEvent:DataEvent)
    func toogleSpiner(event:DataEvent)
    func viewDataEvent() -> DataEvent
}

enum DataEvent: String {
    case svgTextContentChange   = "com.mobilecodelab.svgtextcontentchange"
    case svgLanguageNameChange  = "com.mobilecodelab.svglanguagenamechange"
    case svgTreeModelChange     = "com.mobilecodelab.svgtreemodelchange"
    case dataProcessingBegin    = "com.mobilecodelab.dataprocessingbegin"
    case dataProcessingEnd      = "com.mobilecodelab.dataprocessingend"
    case svgCodeChange          = "com.mobilecodelab.svgcodechange"
    case svgPreviewChange       = "com.mobilecodelab.svgpreviewchange"
}

class ViewModel: NSObject {
    static let svgDataProccessingKey        = "isDataProccessing"
    private var svgDataProccessingCTX:UInt8 = 0
    
    var view:ViewDataBinding?
    var dataEvent:DataEvent = .svgTextContentChange
    @objc dynamic var isDataProccessing:Bool = false
    
    init(view:ViewDataBinding) {
        self.view = view
    }
    
    func renderView(keyPath: String, data:Result<ViewModel,Error>, dataEvent:DataEvent){
        
    }
    
    func updateView(keyPath: String, data:Result<ViewModel,Error>?, dataEvent:DataEvent){
        if keyPath == ViewModel.svgDataProccessingKey {
            switch data {
            case .success(let vm):
                if let v = vm.view {
                    v.toogleSpiner(event: vm.dataEvent)
                }
                break
            default:
                break
            }
        }
    }
    
    func addObserver() {
        addObserver(self, forKeyPath: ViewModel.svgDataProccessingKey, options: [.old, .new], context: &svgDataProccessingCTX)
    }
    
    func removeObserver() {
        removeObserver(self, forKeyPath: ViewModel.svgDataProccessingKey, context: &svgDataProccessingCTX)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let key = keyPath, key == ViewModel.svgDataProccessingKey {
            updateView(keyPath: ViewModel.svgDataProccessingKey, data: nil, dataEvent: .dataProcessingBegin)
        }
    }
    
    deinit {
        removeObserver()
    }
}
