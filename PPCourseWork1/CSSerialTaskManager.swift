//
//  CSSerialTaskManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/14/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSSerialTaskManager: CSTaskManager {

    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    
    func calculateConcurrently() -> CSVector {

        let MOMultMK = dataSource.MO! * dataSource.MK! //1
        
        //X = c*Z
        let ZMultC = dataSource.Z! * dataSource.c! //2
        //Y = c*Z*(MO*MK)
        let Y = ZMultC * MOMultMK //3
        
        
        // K = e * B
        let K = dataSource.B! * dataSource.e! // 4
        
        
        let result = (K + Y).sorted() //5

        
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
