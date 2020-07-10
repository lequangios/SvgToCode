//
//  QyClock.swift
//  SVG2Code
//
//  Created by Le Quang on 7/6/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
import Darwin

class QyClock {
    private(set) var start:UInt64 = 0
    private(set) var end:UInt64 = 0
    private(set) var duration:UInt64 = 0 // in miliseconds
    var log:String { return "executed in \(duration) miliseconds" }
    private(set) var isTickWhenSleep:Bool
    init(isTickWhenSleep:Bool) {
        self.isTickWhenSleep = isTickWhenSleep
    }
    func startTick() { start = run }
    func stopTick() {
        end = run
        duration = getPIDTimeInSeconds()
    }
    class var tick:UInt64 { return mach_absolute_time() }
    class var tickWhenSleep:UInt64 { return mach_continuous_time()}
    private var run:UInt64 {
        if isTickWhenSleep { return QyClock.tickWhenSleep }
        else { return QyClock.tick }
    }
    private func getPIDTimeInSeconds() -> UInt64 {
        var sTimebaseInfo:mach_timebase_info_data_t = mach_timebase_info_data_t()
        let elapsed = (end - start)/1000000
        if (sTimebaseInfo.denom == 0) {
            mach_timebase_info(&sTimebaseInfo);
        }
        return UInt64(UInt32(elapsed) * sTimebaseInfo.numer / sTimebaseInfo.denom)
    }
}
