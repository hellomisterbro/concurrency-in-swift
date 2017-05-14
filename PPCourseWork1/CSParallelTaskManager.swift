//
//  CSParallelTaskManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/14/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSParallelTaskManager: CSTaskManager {
    
    private var queues = [DispatchQueue]()
    private let outputDataGroup = DispatchGroup()
    private let inputDataGroup = DispatchGroup()
    private var semaphores0 = [DispatchSemaphore]()
    
    
    func calculateParallel() -> CSVector{
        for i in 0..<dataSource.P {
            let queue = DispatchQueue(label: "Coursework.calculation-queue-\(i)")
            queues.append(queue)
            let semaphore = DispatchSemaphore(value: 0)
            semaphores0.append(semaphore)
        }
        
        queues[0].sync {
            inputDataGroup.enter()
        }
        queues[dataSource.P - 1].sync {
            inputDataGroup.enter()
        }
        
        
        
        for i in 0..<dataSource.P {
            queues[i].sync {
                self.outputDataGroup.enter()
            }
        }
        
        
        for i in 0..<dataSource.P {
            queues[i].async {
                self.startCalculus(process: i)
            }
        }
        
        outputDataGroup.notify(queue: DispatchQueue.main) {
            print("Fin \(String(describing: self.A))")
        }
        
        outputDataGroup.wait()
        return A
    }
    
    func startCalculus(process: Int) {
        
        let start = startFor(process: process)
        let end = endFor(process: process)
        
        if process == 0 {
            //Input B,MK
            
            inputDataGroup.leave()
        }
        if process == dataSource.P - 1 {
            //Input e, c, Z, MO
            inputDataGroup.leave()
        }
        
        
        //wait till the data is entered
        inputDataGroup.wait()
        
        //Copy Resource
        
        let e = dataSource.e
        let c = dataSource.c
        let Z = dataSource.Z
        let MO = dataSource.MO
        
        //Start calculus
        
        let MOMultMK = MO! * (dataSource.MK?.slice(start: start, end: end))!
        
        //X = c*Z
        let ZMultC = Z! * c!
        
        //Y = c*Z*(MO*MK)
        let Y = ZMultC * MOMultMK
        
        // K = e*B
        let K = (dataSource.B?.slice(start: start, end: end))! * e!
        
        let result = (K + Y).sorted()
        
        A.replacePart(start: start, end: end, vector: result)
        
        
        let depth = Int(ceil(log2(Double(dataSource.P))))
      
        //send signal (process + 1)/2 on
//        if process % 2 == 1  || process == dataSource.P  - 1 {
//            semaphores0[process].signal()
//        } else {
//            
//        }

        if (process == 4) {
        
        }
        
        var endForSort = end
        
        for k in 1...depth {
            var newEnd = 0
            let endProcess = process + Int(pow(Double(2),Double(k))) - 1
            
            //if we should wait for another thread and merge
            if process % (2 * k) == 0 && process != dataSource.P - 1 /*Can delete*/ {
                let processToEnd = endProcess >= dataSource.P ? dataSource.P - 1 : endProcess
                newEnd = endFor(process: processToEnd)
            } else {
                 semaphores0[process].signal()
                break
            }
            
            let processToWait = process + Int(pow(Double(2),Double(k - 1)))
            
            if (processToWait >= dataSource.P) {
                semaphores0[process].signal()
                break
            }
            
            //wait
            semaphores0[processToWait].wait()
            
            A.mergeParts(begin: start, middle: endForSort + 1, end: newEnd)
            //send
            
            if process % (Int(pow(Double(2),Double(k)))) == 0 && process != 0 /*Can delete*/ && !(process % (2 * k) == 0 && process != dataSource.P - 1) {
                semaphores0[process].signal()
                break
            }
            endForSort = newEnd
        }
        if (process == 0) {
            //TODO: output
//        self.A = A
            print(A)
        }
        self.outputDataGroup.leave()
    }
    
}
