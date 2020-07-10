//
//  MainViewModel.swift
//  SVG2Code
//
//  Created by Le Quang on 5/18/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

protocol MainViewDataBinding:ViewDataBinding {
    func syns(tree data:MainViewModel.Model?, error:Error?, dataEvent:MBObserver.DataEvent)
    func syns(preview data:MainViewModel.Model?, error:Error?, dataEvent:MBObserver.DataEvent)
    func syns(code data:MainViewModel.Model?, error:Error?, dataEvent:MBObserver.DataEvent)
}

extension MBObserver.Observer {
    static var svgTextChange:MBObserver.Observer = .init(key: "svgTextContent", context: 0)
    static var svgNameChange:MBObserver.Observer = .init(key: "svgName", context: 1)
    static var svgCodeLange:MBObserver.Observer = .init(key: "svgCodeLange", context: 2)
}

class MainViewModel : ViewModel, QyLogProtocol {
    var logs: [String]
    var isAudit: Bool { return true }
    var begExc: UInt64 = 0
    var endExc: UInt64 = 0
    class Model {
        var isSuccess:Bool = true
        var error:Error?
        var svg:QySVG?
        var svgTreeModel:SVGTreeModel?
        var svgPreviewModel:SVGPreviewModel?
        var svgCode:String?
    }
    
    @objc dynamic var svgTextContent:String = ""
    @objc dynamic var svgName:String = "example"
    @objc dynamic var svgCodeLange:String = LanguageName.Swift.rawValue
    
    var model:Model?
    
    private var observation: NSKeyValueObservation?
    
    override init(view: ViewDataBinding) {
        self.logs = []
        super.init(view: view)
        self.observers = [.svgTextChange, .svgCodeLange, .svgNameChange]
        self.addObserver()
    }
    
    //MARK:- Binding Data to View
    func updateView(success keyPath: String, data: MainViewModel, dataEvent: DataEvent) {
        if let view = self.view as? MainViewDataBinding {
            if keyPath == Observer.svgTextChange.key {
                update(code: data, keyPath: Observer.zero.key)
                update(preview: data, keyPath: Observer.zero.key)
            }
            else {
                if dataEvent == .svgCodeChange {
                    view.syns(code: data.model, error: nil, dataEvent: dataEvent)
                }
                else if dataEvent == .svgPreviewChange {
                    view.syns(preview: data.model, error: nil, dataEvent: dataEvent)
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
        renderProccessingView(keyPath: MBObserver.Observer.svgTextChange.key, dataEvent: .modelChange)
        SVGDataBuilder.buildTree(withName: svgName, svgContent: svgTextContent, audit: true) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.model = model
                self.updateView(keyPath: MBObserver.Observer.svgTextChange.key, data: .success(self), dataEvent: .modelChange)
                break
            case .failure(let error):
                self.updateView(keyPath: MBObserver.Observer.svgTextChange.key, data: .failure(error), dataEvent: .modelChange)
                break
            }
        }
    }
    
    private func update(code vm:MainViewModel, keyPath:String) {
        if let tree = model?.svgTreeModel, let codemaker = LanguageName.init(rawValue: svgCodeLange)?.codeMake() {
            renderProccessingView(keyPath: keyPath, dataEvent: .svgCodeChange)
            SVGDataBuilder.buildCode(withTree: tree, codeMaker: codemaker) { [weak self](result) in
                if let obj = self {
                    switch result {
                    case .success(let code):
                        obj.model?.svgCode = code
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
        if let tree = model?.svg {
            renderProccessingView(keyPath: keyPath, dataEvent: .svgPreviewChange)
            SVGDataBuilder.buildPreview(withTree: tree) { [unowned self](result) in
                switch result {
                case .success(let model):
                    self.model?.svgPreviewModel = model
                    self.updateView(keyPath: keyPath, data: .success(self), dataEvent: .svgPreviewChange)
                    break
                case .failure(let error):
                    self.updateView(keyPath: keyPath, data: .failure(error), dataEvent: .svgPreviewChange)
                    break
                }
            }
        }
        
//        if let tree = model?.svgTreeModel {
//            renderProccessingView(keyPath: keyPath, dataEvent: .svgPreviewChange)
//            SVGDataBuilder.buildPreview(withTree: tree) { [weak self] (result) in
//                if let obj = self {
//                    switch result {
//                    case .success(let model):
//                        obj.model?.svgPreviewModel = model
//                        obj.updateView(keyPath: keyPath, data: .success(obj), dataEvent: .svgPreviewChange)
//                        break
//                    case .failure(let error):
//                        obj.updateView(keyPath: keyPath, data: .failure(error), dataEvent: .svgPreviewChange)
//                        break
//                    }
//                }
//            }
//        }
    }
    
    
    //MARK:- Notification to View Model was changed
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if let key = keyPath {
            for ob in observers {
                if ob == MBObserver.Observer.svgTextChange {
                    update(tree: self)
                }
                else if ob == MBObserver.Observer.svgCodeLange {
                    update(code: self, keyPath: key)
                }
                else if ob == MBObserver.Observer.svgNameChange {
                    update(code: self, keyPath: key)
                }
                else {
                    if isAudit == true { logs.append("Observer with name \(ob.key) isn't handled.") }
                }
            }
        }
    }
    
    deinit {
        printf(self.description)
        removeObserver()
    }
}
