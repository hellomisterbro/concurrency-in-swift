//
//  CSVector.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/11/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSVector {
    private (set) var rawValue = [Int]()
    
    init(array:[Int]) {
        rawValue = array
    }
    
    func slice(start: Int, end: Int) -> CSVector {
        let rawVectorPart = Array(rawValue[start...end])
        return CSVector(array: rawVectorPart)
    }
    
    func sorted() -> CSVector {
        return CSVector(array: rawValue.sorted())
    }
    
    func replacePart(start: Int, end: Int, vector: CSVector) {
        for i in start...end {
            rawValue[i] = vector.rawValue[i - start]
        }
    }
    
    func mergeParts(begin: Int, middle: Int, end: Int) {
        var i = begin, j = middle
        let diff = end - begin
        var result = [Int](repeating: 0, count: diff + 1)
        
        for k in 0...diff {
            if i < middle && (j >= (end + 1) || rawValue[i] <= rawValue[j]) {
                result[k] = rawValue[i]
                i += 1
            } else {
                result[k] = rawValue[j]
                j += 1
            }
        }
        
        rawValue[begin...end] = result[0...diff]
    }
}

extension CSVector {
    
    static func *(left:CSVector, right:Int) -> CSVector {
        return CSVector(array: left.rawValue.map{$0 * right})
    }
    
    static func *(left:Int, right:CSVector) -> CSVector {
        return right * left
    }
    
    static func +(left:CSVector, right:CSVector) -> CSVector {

        let vectorToEnumerate = left.rawValue.count > right.rawValue.count ? right : left
        let vector = left.rawValue.count > right.rawValue.count ? left : right

        let sum = vectorToEnumerate.rawValue.enumerated().map{(key, value) in value + vector.rawValue[key]}
        
        return  CSVector(array: sum);
    }
}
