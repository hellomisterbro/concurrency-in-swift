
//
//  CSRandomizer.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/11/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSRandomizer: NSObject {
    
    private (set) var max: Int
    private (set) var size: Int
    
    init(max: Int, size: Int) {
        self.max = max
        self.size = size
    }

    
     func randomVar() -> Int {
        return Int(arc4random_uniform(UInt32(max))) + 1
    }
   

     func randomVector() -> CSVector {
        return CSVector(array: randomArray())
        
    }

     func randomMatrix() -> CSMatrix {
        var result = [[Int]]()
        
        for _ in 0..<size {
            result.append(randomArray())
        }
        
        return CSMatrix(array: result)
    }
    
    
    private func randomArray() -> [Int] {
        let result = [Int](repeating: 0, count: size)
        return result.map { _ in randomVar()}
        
    }

}
