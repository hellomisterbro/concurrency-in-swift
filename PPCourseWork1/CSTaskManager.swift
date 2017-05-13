//
//  CSTaskManager.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/27/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

//Assignment: A = sort(e*B + c*Z*(MO*MK))

//let matrixMult = self.matrixMult(firstPart: self.MO!, second: MK!)
//
////X = c*Z
//let X = Z!.map {$0 * c!} //correct
//
////Y = c*Z*(MO*MK)
//let Y = matrixVectorMult(vector: X, matrixPart: matrixMult)
//
//// K = e*B
//let K = self.B!.map{e! * $0}//!!!!!!!
//
//let result = vectorSum(first: K, second: Y).sorted()
//
//for i in start...end {
//    self.A![i] = result[i - start]
//}

class CSTaskManager: NSObject {
    
    var A: CSVector!
    
    var dataSource: CSDataSource
    
    private var queues = [DispatchQueue]()
    private let outputDataGroup = DispatchGroup()
    private let inputDataGroup = DispatchGroup()
    private var semaphores0 = [DispatchSemaphore]()
    
    init(dataSource: CSDataSource) {
        self.dataSource = dataSource
    }
    
    func doParallel() -> CSVector{
        for i in 0..<Config.P {
            let queue = DispatchQueue(label: "Coursework.calculation-queue-\(i)")
            queues.append(queue)
            let semaphore = DispatchSemaphore(value: 1)
            semaphores0.append(semaphore)
        }
        
        queues[0].sync {
            inputDataGroup.enter()
        }
        queues[Config.P - 1].sync {
            inputDataGroup.enter()
        }
        
        
        
        for i in 0..<Config.P {
            queues[i].sync {
                self.outputDataGroup.enter()
            }
        }
        
        
        for i in 0..<Config.P {
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
        
        let start = Config.startFor(process: process)
        var end = Config.endFor(process: process)
        
//        let currentQueue = queues[process]
        
        if process == 0 {
            //Input B,MK
            
            inputDataGroup.leave()
        }
        if process == Config.P - 1 {
            //Input e, c, Z, MO
            inputDataGroup.leave()
        }
        
        
        //wait till the data is entered
        inputDataGroup.wait()
        
        //Copy Resource
        
        let e = dataSource.e
        let c = dataSource.c
        let Z = dataSource.Z
        let MK = dataSource.MK
        
        //Start calculus
        
        let matrixMult = (dataSource.MO?.slice(start: start, end: end))! * MK!
        
        //X = c*Z
        let X = Z! * c! 
        
        //Y = c*Z*(MO*MK)
        let Y = X * matrixMult
        
        // K = e*B
        let K = (dataSource.B?.slice(start: start, end: end))! * e!
        
        let result = (K + Y).sorted()
        
        
        var A = result.slice(start: start, end: end)
        
        
        let depth = Int(ceil(log2(Double(Config.P))))
        //send signal (process + 1)/2 on
        if process % 2 == 1 {
            semaphores0[process - 1].signal()
        }
        
        
        
        for k in 1...depth {
            var newEnd = 0
            let endProcess = process + Int(pow(Double(2),Double(k))) - 1
            if process % (2*k) == 0 && process != Config.P - 1 {
                let processToEnd = endProcess >= Config.P ? Config.P - 1 : endProcess
                newEnd = Config.endFor(process: processToEnd)
            } else {
                continue
            }
            //wait
            semaphores0[process + Int(pow(Double(2),Double(k - 1)))].wait()
            
            A.mergeParts(begin: start, middle: end, end: newEnd)
            //send
            
            if process % (Int(pow(Double(2),Double(k)))) == 0 && process != 0 {
                semaphores0[process - Int(pow(Double(2),Double(k)))].signal()
            }
            end = newEnd
        }
        if (process == 0) {
            //TODO: output
            self.A = A
            print(A)
        }
        self.outputDataGroup.leave()
    }
}
