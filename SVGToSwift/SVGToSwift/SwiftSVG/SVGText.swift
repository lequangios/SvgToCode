//
//  SVGText.swift
//  SVGToSwift
//
//  Created by Le Quang on 9/17/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Foundation

final class SVGText{
    
    private var text:String = ""
    
    public var pathNumber:Int = 0
    
    public var layerNumber:Int = 0
    
    static let shared = SVGText()
    
    public func setText(_ text:String){
        self.text = "\(self.text)\n\(text)"
    }
    
    public func getText()->String{
        return self.text
    }
    
    public func resetText(){
        self.text = ""
        self.pathNumber = 0
        self.layerNumber = 0
    }
}
