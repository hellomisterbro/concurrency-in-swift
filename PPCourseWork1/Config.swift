//
//  Config.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class Config: NSObject {
    
    static let N = 19
    static let P = 5
    static let randomMax = 10
    static let isRandom = true //random filling the data
    
    static func HFor(process: Int) -> Int{
        let result = N/P
        let remainder = N%P
        return process >= remainder ? result : (result + 1)
    }
    
    static func startFor(process: Int) -> Int {
        let remainder = N%P
        let delta = N/P
        var start = delta * process
        
        start += (process + 1 > remainder) ? remainder : process
        
        return start
    }
    
    static func endFor(process: Int) -> Int{
        return startFor(process: process) + HFor(process: process) - 1
    }
    
}
