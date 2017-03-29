//
//  AssignmentManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

//Assignment: A = sort(e*B + c*Z*(MO*MK))

class AssignmentManager: NSObject {
    
    var process: Int
    var e: Int?
    var c: Int?
    var Z: [Int]?
    var B: [Int]?
    var MO: [[Int]]?
    var MK: [[Int]]?
    
    var start: Int {
        return Config.startFor(process: process)
    }
    
    var end: Int {
        return Config.endFor(process: process)
    }
    
    init(process: Int) {
        self.process = process
    }
    
    //solution of D = e*B + c*Z*(MO*MK)
    func count(D: inout [Int]){
        let matrixMult = self.matrixMult(firstPart: MO!, second: MK!)
        
        //X = e*Z
        let X = Z!.map {$0 * c!}
        
        //Y = c*Z*(MO*MK)
        let Y = matrixVectorMult(vector: X, matrixPart: matrixMult)
        
        // K = e*B
        let K = B!.map{e! * $0}//!!!!!!!
        
        let result = vectorSum(first: K, second: Y)
        
        for i in start...end {
            D[i] = result[i - start]
        }
        
    }
  //  9	5	7
    //6	4	5
    //7	4	6
    
    func matrixMult(firstPart: [[Int]], second: [[Int]]) -> [[Int]]{
        
        var matrixMult = AssignmentManager.initMatrix(rows: end - start + 1, columns: Config.N)
        
        for i in start...end {
            for j in 0..<Config.N {
                for k in 0..<Config.N{
                    matrixMult[i - start][j] += firstPart[i][k] * second[k][j]
                }
            }
        }
        return matrixMult
    }
    
    func matrixVectorMult(vector: [Int], matrixPart: [[Int]]) -> [Int] {
        var result = AssignmentManager.initVector(count: end - start + 1)
        for i in start...end {
            for j in 0..<Config.N{
                result[i - start] += vector[j] * matrixPart[i - start][j]
            }
        }

        return result
    }
    
    func vectorSum(first: [Int], second: [Int]) -> [Int] {
        var result = [Int]()
        for i in 0..<second.count {
            result.append(first[i] + second[i])
        }
        return result
    }
    
    static func randomMatrix(max: Int) -> [[Int]] {
        var result = [[Int]]()
        for _ in 0..<Config.N {
            result.append(randomVector(max: max))
        }
        return result
    }
    
    static func randomVector(max: Int) -> [Int] {
        let result = [Int](repeating: 0, count: Config.N)
        return result.map { _ in Int(arc4random_uniform(UInt32(max))) + 1}
        
    }
    
    static func initMatrix(rows: Int, columns: Int) -> [[Int]] {
        let row = [Int](repeating: 0, count: columns)
        let result = [[Int]](repeating: row, count: rows)
        return result
    }
    
    static func initVector(count: Int) -> [Int] {
        return [Int](repeating: 0, count: count)
    }
    
}





