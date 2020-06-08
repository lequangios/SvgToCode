//
//  MainViewModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/18/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

protocol MainViewDataBinding:ViewDataBinding {
    func syns(tree data:SVGTreeModel?, error:Error?, dataEvent:DataEvent)
    func syns(preview data:SVGPreviewModel?, error:Error?, dataEvent:DataEvent)
    func syns(code data:String?, error:Error?, dataEvent:DataEvent)
}

class MainViewModel : ViewModel {
    
    private struct MainViewModelObserver {
        static var svgTextChangeCTX:UInt8  = 0
        static var svgNameChangeCTX:UInt8  = 1
        static var svgCodeLangeCTX:UInt8   = 2
    }
    
    static let svgTextContentKey        = "svgTextContent"
    static let svgNameKey               = "svgName"
    static let svgCodeLangeKey          = "svgCodeLange"
    static let svgModelKey              = "svgModelKey"
    
    private var svgTextChangeCTX:UInt8  = 0
    private var svgNameChangeCTX:UInt8  = 1
    private var svgCodeLangeCTX:UInt8   = 2
    
    @objc dynamic var svgTextContent:String = ""
    @objc dynamic var svgName:String = "example"
    @objc dynamic var svgCodeLange:String = LanguageName.Swift.rawValue
    
    var svgTreeModel:SVGTreeModel?
    var svgPreviewModel:SVGPreviewModel?
    var svgCode:String?
    
    private var observation: NSKeyValueObservation?
    
    override func addObserver() {
        super.addObserver()
        addObserver(self, forKeyPath: MainViewModel.svgTextContentKey, options: [.old, .new], context: &svgTextChangeCTX)
        addObserver(self, forKeyPath: MainViewModel.svgNameKey, options: [.old, .new], context: &svgNameChangeCTX)
        addObserver(self, forKeyPath: MainViewModel.svgCodeLangeKey, options: [.old, .new], context: &svgCodeLangeCTX)
    }
    
    override func removeObserver() {
        super.removeObserver()
        removeObserver(self, forKeyPath: MainViewModel.svgTextContentKey, context: &svgTextChangeCTX)
        removeObserver(self, forKeyPath: MainViewModel.svgNameKey, context: &svgNameChangeCTX)
        removeObserver(self, forKeyPath: MainViewModel.svgCodeLangeKey, context: &svgCodeLangeCTX)
    }
    
    //MARK:- Binding Data to View
    func updateView(success keyPath: String, data: MainViewModel, dataEvent: DataEvent) {
        print("updateView - \(keyPath) - \(dataEvent.rawValue)")
        if let view = self.view as? MainViewDataBinding {
            if keyPath == MainViewModel.svgTextContentKey {
                update(code: data, keyPath: MainViewModel.svgModelKey)
                update(preview: data, keyPath: MainViewModel.svgModelKey)
            }
            else {
                if dataEvent == .svgCodeChange {
                    view.syns(code: data.svgCode, error: nil, dataEvent: dataEvent)
                }
                else if dataEvent == .svgPreviewChange {
                    view.syns(preview: data.svgPreviewModel, error: nil, dataEvent: dataEvent)
                }
            }
        }
    }
    
    func updateView(fail keyPath: String, error: Error, dataEvent: DataEvent) {
        if let view = self.view as? MainViewDataBinding {
            view.toogleErrorView(error: error, event: dataEvent)
        }
    }
    
    override func updateView(keyPath: String, data: Result<ViewModel, Error>?, dataEvent: DataEvent) {
        super.updateView(keyPath: keyPath, data: data, dataEvent: dataEvent)
        if let result = data {
            switch result {
            case .success(let model):
                if let vm = model as? MainViewModel {
                    updateView(success: keyPath, data: vm, dataEvent: dataEvent)
                }
                break
            case .failure(let error):
                updateView(fail: keyPath, error: error, dataEvent: dataEvent)
                break
            }
        }
    }
        
    
    //MARK:- Update data from resource
    private func update(tree vm:MainViewModel) {
        renderProccessingView(keyPath: MainViewModel.svgTextContentKey, dataEvent: .modelChange)
        SVGDataBuilder.buildTree(name: svgName, svgContent: svgTextContent, audit: true) { [weak self](result) in
            if let obj = self {
                switch result {
                case .success(let model):
                    obj.svgTreeModel = model
                    obj.updateView(keyPath: MainViewModel.svgTextContentKey, data: .success(obj), dataEvent: .modelChange)
                    break
                case .failure(let error):
                    obj.updateView(keyPath: MainViewModel.svgTextContentKey, data: .failure(error), dataEvent: .modelChange)
                    break
                }
            }
        }
    }
    
    private func update(code vm:MainViewModel, keyPath:String) {
        if let tree = svgTreeModel, let codemaker = LanguageName.init(rawValue: svgCodeLange)?.codeMake() {
            renderProccessingView(keyPath: keyPath, dataEvent: .svgCodeChange)
            SVGDataBuilder.buildCode(withTree: tree, codeMaker: codemaker) { [weak self](result) in
                if let obj = self {
                    switch result {
                    case .success(let code):
                        obj.svgCode = code
                        obj.updateView(keyPath: keyPath, data: .success(obj), dataEvent: .svgCodeChange)
                        break
                    case .failure(let error):
                        obj.updateView(keyPath: keyPath, data: .failure(error), dataEvent: .svgCodeChange)
                        break
                    }
                }
            }
        }
    }
    
    private func update(preview vm:MainViewModel, keyPath:String) {
        if let tree = svgTreeModel {
            renderProccessingView(keyPath: keyPath, dataEvent: .svgPreviewChange)
            SVGDataBuilder.buildPreview(withTree: tree) { [weak self] (result) in
                if let obj = self {
                    switch result {
                    case .success(let model):
                        obj.svgPreviewModel = model
                        obj.updateView(keyPath: keyPath, data: .success(obj), dataEvent: .svgPreviewChange)
                        break
                    case .failure(let error):
                        obj.updateView(keyPath: keyPath, data: .failure(error), dataEvent: .svgPreviewChange)
                        break
                    }
                }
            }
        }
    }
    
    
    //MARK:- Notification to View Model was changed
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if let key = keyPath {
            if key == MainViewModel.svgTextContentKey {
                update(tree: self)
            }
            else if key == MainViewModel.svgCodeLangeKey {
                update(code: self, keyPath: key)
            }
            else if key == MainViewModel.svgNameKey {
                update(code: self, keyPath: key)
            }
        }
    }
    
    deinit {
        print("deinit MainViewModel")
        removeObserver()
    }
}
