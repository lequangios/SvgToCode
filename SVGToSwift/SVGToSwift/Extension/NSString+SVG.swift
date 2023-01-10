//
//  NSString+SVG.swift
//  SVGToSwift
//
//  Created by Le Quang on 10/01/2023.
//  Copyright © 2023 Le Viet Quang. All rights reserved.
//

import AppKit

extension String {
    public func makePoints() -> [CGPoint] {
        var points = [CGPoint]()
        let nums = self.split(separator: " ")
        if self.contains(",") && nums.count > 2 {
            for item in nums {
                let p = item.split(separator: ",")
                if p.count > 1 {
                    let x = CGPoint(x: String(p[0]).doubleValue, y: String(p[1]).doubleValue)
                    points.append(x)
                }
            }
        }
        else if nums.count > 5 && nums.count%2 == 0 {
            for i in stride(from: 0, to: nums.count, by: 2) {
                points.append(CGPoint(x: String(nums[i]).doubleValue, y: String(nums[i+1]).doubleValue))
            }
        }
        return points
    }
    
    public func makeStyle() -> [String:String] {
        var styles = [String:String]()
        let lists = self.split(separator: ";")
        for item in lists {
            let arr = item.split(separator: ":")
            if arr.count > 1 {
                styles[String(arr[0])] = String(arr[1])
            }
        }
        return styles
    }
}
