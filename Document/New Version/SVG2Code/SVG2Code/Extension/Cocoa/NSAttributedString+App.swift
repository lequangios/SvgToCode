//
//  NSAttributedString+App.swift
//  SVG2Code
//
//  Created by Le Quang on 6/28/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

extension NSAttributedString {
    static func attribute(fromHTML html:String) throws -> NSAttributedString? {
        let htmlData = NSString(string: html).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        do {
            let attributedString = try NSMutableAttributedString(data: htmlData ?? Data(), options: options, documentAttributes: nil)
            return attributedString
        }
        catch let e {
            throw e
        }
    }
}
