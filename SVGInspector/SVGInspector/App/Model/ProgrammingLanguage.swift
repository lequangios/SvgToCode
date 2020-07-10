//
//  ProgrammingLanguage.swift
//  SVGInspector
//
//  Created by Le Quang on 7/10/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

struct ProgrammingLanguage {
    var rawValue:String
    static let swift:ProgrammingLanguage            = .init(rawValue: "Swift")
    static let objectiveC:ProgrammingLanguage       = .init(rawValue: "Objective C")
    static let javascript:ProgrammingLanguage       = .init(rawValue: "Javascript")
    static let kotlin:ProgrammingLanguage           = .init(rawValue: "Kotlin")
}

extension ProgrammingLanguage {
    static var available:[ProgrammingLanguage] { return [.swift] }
}
