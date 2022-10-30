//
//  MBObserver.swift
//  SVG2Code
//
//  Created by Le Quang on 5/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class MBObserver : NSObject {
    public struct Observer : Equatable {
        var key:String = ""
        var context:Int = 0
        static let zero:Observer = .init(key: "none", context: -1000)
    }
    
    public struct DataEvent : Equatable {
        var key:String = ""
        var value:String = ""
        var notification:Notification.Name { return Notification.Name(value)}
    }
    
    struct DataKey {
        var rawValue:String
        static let code:DataKey = .init(rawValue: "code")
        static let info:DataKey = .init(rawValue: "info")
        static let file:DataKey = .init(rawValue: "file")
    }
    
    deinit {
        
    }
}

extension NSObject {
    func add(observer:inout MBObserver.Observer){
        addObserver(self, forKeyPath: observer.key, options: [.old, .new], context: &(observer.context))
    }
    
    func remove(observer:inout MBObserver.Observer){
        removeObserver(self, forKeyPath: observer.key, context: &(observer.context))
    }
}

extension NotificationCenter {
    class func post(Event anEvent:MBObserver.DataEvent, object anObject: Any?) {
        NotificationCenter.default.post(name: anEvent.notification, object: anObject)
    }
    class func add(Event anEvent:MBObserver.DataEvent,observer anObserver: Any, selector aSelector: Selector, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(anObserver, selector: aSelector, name: anEvent.notification, object: anObject)
    }
    class func remove(Event anEvent:MBObserver.DataEvent,observer anObserver: Any, object anObject: Any? = nil){
        NotificationCenter.default.removeObserver(anObserver, name: anEvent.notification, object: anObject)
    }
}
