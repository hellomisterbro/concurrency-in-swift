//
//  Config.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class Config: NSObject {
    
    static let N = 4
    static let P = 2
    static let randomMax = 4
    static let isRandom = true //random filling the data

    static func startFor(process: Int) -> Int {
        let remainder = N % P
        let delta = N / P
        var start = delta * process
        
        start += (process + 1 > remainder) ? remainder : process
        
        return start
    }
    
    static func endFor(process: Int) -> Int{
        let remainder = N%P
        let delta = N/P
        let end = (process + 1 > remainder) ? delta : delta + 1
        return startFor(process: process) + end - 1
    }
}




