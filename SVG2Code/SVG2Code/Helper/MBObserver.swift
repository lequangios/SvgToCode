//
//  MBObserver.swift
//  SVG2Code
//
//  Created by Le Quang on 5/20/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class MBObserver : NSObject {
    @objc dynamic var objectToObserve: AnyObject?
    var observation: NSKeyValueObservation?
    
    init(object: AnyObject?) {
        super.init()
        if let obj = object {
            objectToObserve = object
            observation = observe(\.objectToObserve, options: [.old, .new], changeHandler: { (obj, change) in
                
            })
        }
    }
    
    deinit {
        
    }
}
