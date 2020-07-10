//
//  Foundation.swift
//  SVG2Code
//
//  Created by Le Quang on 6/13/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation


//extension Substring {
//    var value:String { return String(self) }
//}

//extension String {
//    var number:NSNumber {
//        return NSNumber(value: strtod(self, nil))
//    }
//    
//    var isEmpty:Bool {
//        let pattern = "([ \t\n\r]+)"
//        return (count == 0) || isMatch(withPattern: pattern)
//    }
//    
//    var data:Data? { return self.data(using: .utf8) }
//    
//    var range:NSRange { return NSRange(location: 0, length: self.count) }
//    
//    subscript (bounds: CountableClosedRange<Int>) -> String {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        return String(self[start...end])
//    }
//    
//    subscript (bounds: CountableRange<Int>) -> String {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        return String(self[start..<end])
//    }
//    
//    func substring(with range:NSTextCheckingResult) -> String {
//        return self[range.range.lowerBound..<(range.range.length+range.range.lowerBound)]
//    }
//    
//    func substring(with range:NSRange) -> String {
//        return self[range.lowerBound..<(range.length + range.lowerBound)]
//    }
//    
//    func isMatch(withPattern pattern:String) -> Bool {
//        let regex = NSPredicate(format:"SELF MATCHES %@", pattern)
//        return regex.evaluate(with: self)
//    }
//    
//    func find(withPattern pattern:String, option:NSRegularExpression.Options = .caseInsensitive) -> [QyMatchPaternResult] {
//        do {
//            let regex = try NSRegularExpression(pattern: pattern, options: option)
//            return regex.matches(in: self, options: [], range: range).map{
//                QyMatchPaternResult(range: $0.range, value: self.substring(with: $0))
//            }
//        }
//        catch let e {
//            print("\(e.localizedDescription)")
//            return []
//        }
//    }
//    
//    func findFirst(withPattern pattern:String, option:NSRegularExpression.Options = .caseInsensitive) -> QyMatchPaternResult? {
//        do {
//            let regex = try NSRegularExpression(pattern: pattern, options: option)
//            if let result = regex.firstMatch(in: self, options: [], range: range) {
//                return QyMatchPaternResult(range: result.range, value: self.substring(with: result))
//            }
//            return nil
//        }
//        catch let e {
//            print("\(e.localizedDescription)")
//            return nil
//        }
//    }
//    
//    func split(byPair pair:Character, group:Character) -> [String:String] {
//        var dicts:[String:String] = [:]
//        var key = "", value = ""
//        var keyBg = true, valueBg = false
//        for c in self {
//            if keyBg == true {
//                if c == pair {
//                    keyBg = false
//                    valueBg = true
//                }
//                else { key.append(c) }
//            }
//            else  if valueBg == true {
//                if c == group {
//                    dicts[key] = value
//                    key = ""
//                    value = ""
//                    valueBg = false
//                    keyBg = true
//                }
//                else { value.append(c) }
//            }
//        }
//        return dicts
//    }
//    
//    func find(inTag tag:String, pattern:String = ".+") -> [QyMatchPaternResult] {
//        let pattern = "(?<=<\(tag)>)\(pattern)?(?=<//\(tag)>)"
//        return find(withPattern: pattern)
//    }
//    
//    func find(inGroup group:String, pattern:String = ".+") -> [QyMatchPaternResult] {
//        let pattern = "(?<=\(group))\(pattern)?(?=//\(group))"
//        return find(withPattern: pattern)
//    }
//}

extension NSArray {
    func filtered(byKey key:String, value:String) -> [Any] {
        let predicate = NSPredicate(format: "%K = %@", key, value)
        return self.filtered(using: predicate)
    }
}
