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
    
    private var A: CSVector
    
    var dataSource: CSDataSource
    
    private var queues = [DispatchQueue]()
    private let outputDataGroup = DispatchGroup()
    private let inputDataGroup = DispatchGroup()
    private var semaphores0 = [DispatchSemaphore]()
    
    init(dataSource: CSDataSource) {
        self.dataSource = dataSource
        A = CSVector(array:[Int](repeating:0, count: dataSource.N))
    }
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    
    func calculate() -> CSVector{
        
        let MOMultMK = dataSource.MK! * dataSource.MO!
        
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
        
        let MOMultMK = (dataSource.MK?.slice(start: start, end: end))! * dataSource.MO!
        
        //X = c*Z
        let ZMultC = dataSource.Z! * dataSource.c!
        
        //Y = c*Z*(MO*MK)
        let Y = ZMultC * MOMultMK
        
        // K = e*B
        let K = (dataSource.B?.slice(start: start, end: end))! * dataSource.e!
        
        let result = K + Y
        
        A.replacePart(start: start, end: end, vector: result)
    }
    
    func calculateParallel() -> CSVector{
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
