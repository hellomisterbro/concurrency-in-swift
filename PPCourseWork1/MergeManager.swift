//
//  MergeManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class MergeManager: NSObject {
    
    public static func merge<T:Comparable>(left: [T], right: [T], comparison: ((T, T) -> Bool)? = nil) -> [T] {
        
        //use default parameter
        guard let comparison = comparison else {
            return merge(left: left, right: right, comparison: <)
        }
        
        var result = [T]()
        var left = left
        var right = right
        
        while let firstLeft = left.first, let firstRight = right.first {
            
            if comparison(firstLeft, firstRight) {
                result.append(firstLeft)
                left.removeFirst()
            } else {
                result.append(firstRight)
                right.removeFirst()
            }
        }
        
        result.append(contentsOf: left)
        result.append(contentsOf: right)
        
        return result;
    }
 
}
