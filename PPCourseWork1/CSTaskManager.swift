//
//  CSTaskManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/27/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

//Assignment: A = sort(e*B + c*Z*(MO*MK))


class CSTaskManager: NSObject {
    
    internal var A: CSVector
    
    var dataSource: CSDataSource
    
    init(dataSource: CSDataSource) {
        self.dataSource = dataSource
        A = CSVector(array:[Int](repeating:0, count: dataSource.N))
    }
    
    func startFor(process: Int) -> Int {
        let remainder = dataSource.N % dataSource.P
        let delta = dataSource.N / dataSource.P
        var start = delta * process
        
        start += (process + 1 > remainder) ? remainder : process
        
        return start
    }
    
    func endFor(process: Int) -> Int{
        let remainder = dataSource.N % dataSource.P
        let delta = dataSource.N / dataSource.P
        
        let end = (process + 1 > remainder) ? delta : delta + 1
        
        return startFor(process: process) + end - 1
    }
}
