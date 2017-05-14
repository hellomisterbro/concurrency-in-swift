//
//  CSConcurrentTaskManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/14/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSConcurrentTaskManager: CSTaskManager {

    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    
    func calculateConcurrently() -> CSVector{
        
        let MOMultMK = dataSource.MO! * dataSource.MK!
        
        //X = c*Z
        let ZMultC = dataSource.Z! * dataSource.c!
        
        //Y = c*Z*(MO*MK)
        let Y = ZMultC * MOMultMK
        
        // K = e*B
        let K = dataSource.B! * dataSource.e!
        
        let result = (K + Y).sorted()
        
        
        return result
    }
    
    func calculateSeparately() -> CSVector {
        for i in 0..<dataSource.P {
            calculate(process: i)
        }
        return A.sorted()
    }
    
    private func calculate(process: Int) {
        
        let start = startFor(process: process)
        let end = endFor(process: process)
        
        let MOMultMK = dataSource.MO! * (dataSource.MK?.slice(start: start, end: end))!
        
        //X = c*Z
        let ZMultC = dataSource.Z! * dataSource.c!
        
        //Y = c*Z*(MO*MK)
        let Y = ZMultC * MOMultMK
        
        // K = e*B
        let K = (dataSource.B?.slice(start: start, end: end))! * dataSource.e!
        
        let result = K + Y
        
        A.replacePart(start: start, end: end, vector: result)
    }
    
}
