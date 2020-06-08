//
//  CodeGeneration.swift
//  SVG2Code
//
//  Created by Le Quang on 5/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

class CodeGeneration {
    var codemaker:CodeGenerationProtocol
    
    init(codemaker:CodeGenerationProtocol) {
        self.codemaker = codemaker
    }
}
