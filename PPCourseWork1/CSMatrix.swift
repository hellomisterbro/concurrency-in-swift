//
//  CSMatrix.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/11/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSMatrix {
    private (set) var rawValue = [[Int]]()
    
    init(array: [[Int]]) {
        rawValue = array
    }
    
    func slice(start: Int, end: Int) -> CSMatrix{
        let rawMatrixPart = rawValue.map{Array($0[start...end])}
        return CSMatrix(array: rawMatrixPart)
    }
    
    
    func replacePart(start: Int, end: Int, matrix: CSMatrix) {
        for i in start..<end {
            rawValue[i] = matrix.rawValue[i - start]
        }
    }
    
}

extension CSMatrix {
    
    static func *(matrix: CSMatrix, vector: CSVector) -> CSVector {

        return vector * matrix
    }
    
    static func *(vector: CSVector, matrix: CSMatrix) -> CSVector {
        
        var result = [Int](repeating: 0, count: matrix.rawValue[0].count)
        
        for i in 0..<matrix.rawValue[0].count {
            for j in 0..<vector.rawValue.count {
                result[i] += vector.rawValue[j] * matrix.rawValue[j][i]
            }
        }
        return CSVector(array: result)
    }
    
    static func *(madtrix2: CSMatrix, matrix1: CSMatrix) -> CSMatrix {
        let row = [Int](repeating: 0, count: matrix1.rawValue[0].count)
        var result = [[Int]](repeating: row, count: matrix1.rawValue.count)
        
        for i in 0..<matrix1.rawValue[0].count {
            for j in 0..<matrix1.rawValue.count {
                for k in 0..<matrix1.rawValue.count {
                    result[j][i] += matrix1.rawValue[k][i] * madtrix2.rawValue[j][k]
                }
            }
        }
        
        return CSMatrix(array: result)
    }
    
}
