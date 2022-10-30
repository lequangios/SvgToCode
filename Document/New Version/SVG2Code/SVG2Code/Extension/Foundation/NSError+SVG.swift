//
//  NSError+SVG.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

public let NSLocalizedUserCustomErrorKey: String = "NSLocalizedUserCustomErrorKey"
public let NSLocalizedTypeErrorKey: String = "NSLocalizedTypeErrorKey"

enum NSErrorDomain : String {
    case NSAppDomain        = "com.mobilecodelab.svg2code"
    case svgXMLPaserDomain  = "com.mobilecodelab.svgtreebuild"
    case svgDataValidate    = "com.mobilecodelab.svgdatavalidate"
}

enum NSErrorType : Int {
    case Primary = 0
    case Information = 1
    case Success = 2
    case Warning = 3
    case Danger = 4
}

enum NSErrorCode : Int {
    case internalCode = 100
}

extension NSError {
    convenience init(message: String, type:NSErrorType = .Danger) {
        let domain = Bundle.main.bundleIdentifier ?? NSErrorDomain.NSAppDomain.rawValue
        self.init(domain: domain, code: NSErrorCode.internalCode.rawValue, userInfo: [NSLocalizedDescriptionKey:message,
                                                                                      NSLocalizedTypeErrorKey: type.rawValue,
                                                                                      NSLocalizedFailureReasonErrorKey:message])
    }
    
    convenience init(domain:String, code:Int, description:String, failureReason:String, type:NSErrorType = .Danger, userData:String = ""){
        let userInfo = [NSLocalizedDescriptionKey:description,
                        NSLocalizedFailureReasonErrorKey:failureReason,
                        NSLocalizedTypeErrorKey: type.rawValue,
                        NSLocalizedUserCustomErrorKey:userData] as [String : Any]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
    
    var type:NSErrorType {
        if let t = userInfo[NSLocalizedTypeErrorKey] as? NSString { return NSErrorType.init(rawValue: t.integerValue) ?? .Danger }
        else { return .Danger }
    }
    
    var message:String {
        if let des = userInfo[NSLocalizedDescriptionKey] as? String { return des }
        else { return localizedDescription }
    }
    
    var failureReason:String {
        if let reason = userInfo[NSLocalizedFailureReasonErrorKey] as? String { return reason }
        else { return "" }
    }
    
    var customData:String {
        if let data = userInfo[NSLocalizedUserCustomErrorKey] as? String { return data }
        else { return "" }
    }
}

extension Error {
    var type:NSErrorType {
        return (self as NSError).type
    }
    
    var message:String {
        return (self as NSError).message
    }
    
    var failureReason:String {
        return (self as NSError).failureReason
    }
    
    var customData:String {
        return (self as NSError).customData
    }
}
