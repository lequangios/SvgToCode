//
//  NSError+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

public let NSLocalizedUserCustomErrorKey: String = "NSLocalizedUserCustomErrorKey"
public let NSLocalizedTypeErrorKey: String = "NSLocalizedTypeErrorKey"

enum NSErrorType : Int {
    case Primary = 0
    case Information = 1
    case Success = 2
    case Warning = 3
    case Danger = 4
}

struct NSErrorInformation {
    var domain:String
    var code:Int
    var type:NSErrorType = .Information
    static let internalError:NSErrorInformation = .init(domain: "com.mobilecodelab.svginspector", code: 99999, type: .Information)
    static let fileNotFound:NSErrorInformation = .init(domain: "com.mobilecodelab.svginspector", code: 99998, type: .Information)
}

extension NSError {
    convenience init(message: String, type:NSErrorType = .Danger) {
        let code = NSErrorInformation.internalError.code
        let domain = Bundle.main.bundleIdentifier ?? NSErrorInformation.internalError.domain
        self.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey:message,
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
    
    convenience init(information:NSErrorInformation, description:String, failureReason:String, userData:String = "") {
        let userInfo = [NSLocalizedDescriptionKey:description,
                        NSLocalizedFailureReasonErrorKey:failureReason,
                        NSLocalizedTypeErrorKey: NSErrorInformation.internalError.type.rawValue,
                        NSLocalizedUserCustomErrorKey:userData] as [String : Any]
        self.init(domain: NSErrorInformation.internalError.domain, code: NSErrorInformation.internalError.code, userInfo: userInfo)
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
