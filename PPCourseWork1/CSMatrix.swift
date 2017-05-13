//
//  CSMatrix.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/11/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

struct CSMatrix {
    private (set) var rawValue = [[Int]]()
    
    init(array: [[Int]]) {
        rawValue = array
    }
    
    func slice(start: Int, end: Int) -> CSMatrix{
        let rawMatrixPart = Array(rawValue[start...end])
        return CSMatrix(array: rawMatrixPart)
    }
    
}

extension CSMatrix {
    
    static func *(matrix: CSMatrix, vector: CSVector) -> CSVector {
        var result = [Int](repeating: 0, count: matrix.rawValue.count)
        
        for i in 0..<matrix.rawValue.count {
            for j in 0..<vector.rawValue.count {
                result[i] += vector.rawValue[j] * matrix.rawValue[i][j]
            }
        }
        return CSVector(array: result)
    }
    
    static func *(vector: CSVector, matrix: CSMatrix) -> CSVector {
        return matrix * vector
    }
    
    static func *(matrix1: CSMatrix, matrix2: CSMatrix) -> CSMatrix {
        var result = [[Int]]()
        
        for i in 0..<matrix1.rawValue.count {
            for j in 0..<matrix2.rawValue.count {
                for k in 0..<matrix2.rawValue.count {
                    result[i][j] += matrix1.rawValue[i][k] * matrix2.rawValue[k][j]
                }
            }
        }
        return CSMatrix(array: result)
    }
    
}
