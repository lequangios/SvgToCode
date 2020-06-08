//
//  WKWebView+App.swift
//  SVG2Code
//
//  Created by Le Quang on 6/5/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import WebKit

extension WKWebView {
    func loadHTML(inDirectory directory:String) throws -> WKNavigation? {
        do {
            if let filepath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: directory) {
                let content = try String(contentsOfFile: filepath)
                let url = URL(fileURLWithPath: filepath)
                return loadHTMLString(content, baseURL: url)
            }
            else {
                let error = NSError(message: "index.html can not found at \(directory)")
                throw error
            }
        }
        catch let error {
            throw error
        }
    }
    
    func executeJSFunction(withName name:String, arguments:[String]) {
        var caller = ""
        
        if arguments.count > 0 {
            let args = arguments.map { (item) -> String in
                return "\"\(item.htmlDecode)\""
            }.joined(separator: ",")
            caller = "\(name)(\(args))"
        }
        else {
            caller = "\(name)()"
        }
        
        evaluateJavaScript(caller) { (_, error) in
            if let e = error {
                print("executeJSFunction = \(e.message)")
            }
        }
    }
}
