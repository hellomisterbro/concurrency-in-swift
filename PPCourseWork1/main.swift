//
//  main.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/24/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Foundation

func testParallel(processors: Int, elements: Int) {
    
    print("\(processors) thread with \(elements) elements started.")
    
    let dataSource1 = CSDataSource(numberOfProcesses: processors, size: elements)
    
    dataSource1.randomizeAll()
    
    let methodStart = Date()
    
    let parallelManager = CSParallelTaskManager(dataSource: dataSource1)
    let _ = parallelManager.calculateParallel()
    
    let methodFinish = Date()
    let executionTime = methodFinish.timeIntervalSince(methodStart)
    
    print("Time for \(processors) threads with \(elements) elements: \(executionTime).")
}

func testConcurrent(elements: Int) {
  
    print("1 thread with \(elements) elements started.")
    
    let dataSource1 = CSDataSource(numberOfProcesses: 1, size: elements)
    
    dataSource1.randomizeAll()
    
    let methodStart = Date()
    
    let parallelManager = CSConcurrentTaskManager(dataSource: dataSource1)
    let _ = parallelManager.calculateConcurrently()
    
    let methodFinish = Date()
    let executionTime = methodFinish.timeIntervalSince(methodStart)
    
    print("\nTime for 1 thread with \(elements) elements: \(executionTime).")
    
}

func test(elements: Int) {
    testConcurrent(elements: elements)
    testParallel(processors: 2, elements: elements)
    testParallel(processors: 3, elements: elements)
    testParallel(processors: 4, elements: elements)
}


test(elements: 900)
test(elements: 1800)
test(elements: 2400)







