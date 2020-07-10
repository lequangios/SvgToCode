//
//  MainViewModel.swift
//  SVGInspector
//
//  Created by Le Quang on 7/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class MainViewModel: NSObject {
    @objc dynamic var svgContent:String
    @objc dynamic var programming:String
    
    override init() {
        svgContent  = ""
        programming = ""
        super.init()
    }
}
