//
//  AssignmentManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/25/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa
import Darwin

//Assignment: A = sort(e*B + c*Z*(MO*MK))

class AssignmentManager: NSObject {
    
    var process: Int
    var e: Int?
    var c: Int?
    var Z: [Int]?
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
    
    func copyResources(){
        e = DataStorage.shared.e
        c = DataStorage.shared.c
        Z = DataStorage.shared.Z
        MK = DataStorage.shared.MK
    }
    
    //solution of D = e*B + c*Z*(MO*MK)
    func equationCalculus(D: inout [Int]){
        
        let matrixMult = self.matrixMult(firstPart: DataStorage.shared.MO!, second: MK!)
        
        //X = e*Z
        let X = Z!.map {$0 * c!}
        
        //Y = c*Z*(MO*MK)
        let Y = matrixVectorMult(vector: X, matrixPart: matrixMult)
        
        // K = e*B
        let K = DataStorage.shared.B!.map{e! * $0}//!!!!!!!
        
        let result = vectorSum(first: K, second: Y)
        
        for i in start...end {
            D[i] = result[i - start]
        }
        
    }
    
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
    
    static func initMatrix(rows: Int, columns: Int) -> [[Int]] {
        let row = [Int](repeating: 0, count: columns)
        let result = [[Int]](repeating: row, count: rows)
        return result
    }
    
    static func initVector(count: Int) -> [Int] {
        return [Int](repeating: 0, count: count)
    }
    
}





