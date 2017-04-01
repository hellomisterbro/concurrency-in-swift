//
//  MergeManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa
import Darwin

class MergeManager: NSObject {
    
    public static func topDownMerge(list: inout [Int], begin: Int,
                      middle: Int, end: Int) {
        var i = begin, j = middle
        let diff = end - begin
        var result = [Int](repeating: 0, count: diff + 1)
        
        for k in 0...diff {
            if i < middle && (j >= (end + 1) || list[i] <= list[j]) {
                result[k] = list[i]
                i += 1
            } else {
                result[k] = list[j]
                j += 1
            }
        }
        
        list[begin...end] = result[0...diff]
    }
 
}





