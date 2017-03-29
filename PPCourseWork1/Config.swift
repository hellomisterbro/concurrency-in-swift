//
//  Config.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class Config: NSObject {
    
    static let N = 100
    static let P = 2
    static let randomMax = 10
    static let isRandom = true //random filling the matrix
    
    static func HFor(process: Int) -> Int{
        let result = N/P
        let remainder = N%P
        return process >= remainder ? result : (result + 1)
    }
    
    static func startFor(process: Int) -> Int {
        var start = 0
        for i in 0..<process{
            start += HFor(process: i)
        }
        return start
    }
    
    static func endFor(process: Int) -> Int{
        return startFor(process: process) + HFor(process: process) - 1
    }
    
}
