//
//  LanguageEnum.swift
//  SVG2Code
//
//  Created by Le Quang on 5/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

enum LanguageName : String {
    case Swift = "Swift"
    case Obj = "Objective-C"
    case Js = "Javascript Canvas"
    case MacOSX = "Mac"
    
    func all() -> [LanguageName] {
        return [LanguageName.Swift];
    }
    
    func allowFiles() -> [String] {
        switch self {
        case .Swift:
            return ["swift"]
        default:
            return ["swift"]
        }
    }
    
    func codeMake() -> CodeGenerationProtocol {
        switch self {
        case .Swift:
            return SwiftCodeGeneration()
        default:
            return SwiftCodeGeneration()
        }
    }
}
