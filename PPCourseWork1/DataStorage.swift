//
//  DataStorage.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/27/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class DataStorage: NSObject {
    
    //shared resources (NO)
    var e: Int?
    var c: Int?
    var Z: [Int]?
    var MK: [[Int]]?
    
    //not shared
    var B: [Int]?
    var A: [Int]?
    var MO: [[Int]]?

    
    static let shared = DataStorage()
    
    private override init() {}
    
    func randomizeDataFirst(max: Int){
        A = [Int](repeating: 0, count: Config.N)
        B = randomVector(max: max)
        MK = randomMatrix(max: max)
    }

    func randomizeDataSecond(max: Int){
        e = randomVar(max: max)
        c = randomVar(max: max)
        Z = randomVector(max: max)
        MO = randomMatrix(max: max)
    }
    
    func randomMatrix(max: Int) -> [[Int]] {
        var result = [[Int]]()
        for _ in 0..<Config.N {
            result.append(randomVector(max: max))
        }
        return result
    }
    
    func randomVector(max: Int) -> [Int] {
        let result = [Int](repeating: 0, count: Config.N)
        return result.map { _ in randomVar(max: max)}
        
    }
    
    func randomVar(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max))) + 1
    }
    
}
