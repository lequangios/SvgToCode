//
//  NSError+SVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/8/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
extension NSError {
    convenience init(msg: String) {
        self.init(domain: "SVG", code: 999, userInfo: ["message": msg])
    }
    
    static func makeError(_ domain:String, description:String, failureReason:String, userData:String = "")-> Error{
        let userInfo = [NSLocalizedDescriptionKey:description, NSLocalizedFailureReasonErrorKey:failureReason, "user_data":userData]
        return NSError.init(domain: domain, code: Int.min, userInfo: userInfo)
    }
    
    func getMessage()->String {
        if let msg = self.userInfo["message"] as? String {
            return msg
        }
        return "Unknow message"
    }
}

extension Error {
    func getMessage()->String {
        return (self as NSError).getMessage()
    }
}
