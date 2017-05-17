//
//  CSParallelTaskManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/14/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSParallelTaskManager: CSTaskManager {

    private let outputDataGroup = DispatchGroup()
    private let sortDataGroup = DispatchGroup()
    private var semaphores = [DispatchSemaphore]()
    
    private var semaphore = DispatchSemaphore(value: 0)
    
    
    func calculateParallel() -> CSVector{
        
        let queue = DispatchQueue(label: "Dispatch queue", attributes: .concurrent)
        
        semaphores = [DispatchSemaphore](repeating: DispatchSemaphore(value: 0), count:dataSource.P)
        
        for i in 0..<dataSource.P {
            queue.async {
                self.outputDataGroup.enter()
                self.semaphore.signal()
                
                self.sortDataGroup.enter()
                
                self.startCalculus(process: i)
            }
        }
    
        semaphore.wait()
        outputDataGroup.wait()
        
        return A
    }
    
    func startCalculus(process: Int) {
        
        let start = startFor(process: process)
        let end = endFor(process: process)
        
        let e = dataSource.e
        let c = dataSource.c
        let Z = dataSource.Z
        let MO = dataSource.MO
        
        // MOH * MK
        let MOMultMK = MO! * (dataSource.MK?.slice(start: start, end: end))!
        
        //X = c*Z
        let ZMultC = Z! * c!
        
        //Y = c*Z*(MO*MK)
        let Y = ZMultC * MOMultMK
        
        // K = e*B
        let K = (dataSource.B?.slice(start: start, end: end))! * e!
        
        let result = (K + Y).sorted()
        
        A.replacePart(start: start, end: end, vector: result)
        
        sortDataGroup.leave()
        sortDataGroup.wait()
        
        let depth = Int(ceil(log2(Double(dataSource.P))))
        
        var endForSort = end
        
        for k in 1...depth {
            
            var newEnd = 0
            let endProcess = process + Int(pow(Double(2),Double(k))) - 1
            let processToWait = process + Int(pow(Double(2),Double(k - 1)))
            
            
            if process % (2 * k) == 0 && process != dataSource.P - 1 && processToWait < dataSource.P {
                
                let processToEnd = endProcess >= dataSource.P ? dataSource.P - 1 : endProcess
                newEnd = endFor(process: processToEnd)
                
            } else {
                semaphores[process].signal()
                break
            }
            
            semaphores[processToWait].wait()
            
            A.mergeParts(begin: start, middle: endForSort + 1, end: newEnd)
            
            endForSort = newEnd
        }
        
        self.outputDataGroup.leave()
    }
    
}
