//
//  PPCourseWorkUnitTests.swift
//  PPCourseWorkUnitTests
//
//  Created by Nikita Kirichek on 5/13/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import XCTest
//@testable import PPCourseWork1

class PPCourseWorkUnitTests: XCTestCase {
    
    var dataSource1: CSDataSource!
    var dataSource2: CSDataSource!
    
    override func setUp() {
        super.setUp()
        
        let dataSource1 = CSDataSource(numberOfProcesses: 3, size: 4)
        
        dataSource1.e = 2
        dataSource1.c = 1
        
        dataSource1.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource1.MO = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.MK = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.B = CSVector(array:[1, 8, 1, 1])
        
        self.dataSource1 = dataSource1
        
        let dataSource2 = CSDataSource(numberOfProcesses: 4, size: 4)
        
        dataSource2.e = 2
        dataSource2.c = 1
        
        dataSource2.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource2.MO = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource2.MK = CSMatrix(array: [[1, 1, 1, 1],
                                          [1, 1, 1, 1],
                                          [1, 1, 1, 1],
                                          [1, 1, 1, 1]])
        
        dataSource2.B = CSVector(array:[1, 8, 1, 1])
        
        self.dataSource2 = dataSource2
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMathematicalVectorCalcucaltion() {
        
        var vector1 = CSVector(array:[1, 1, 1, 1])
        var vector2 = CSVector(array:[1, 1, 1, 1])
        
        var result = vector1 + vector2
        
        XCTAssertEqual(result.rawValue, [2, 2, 2, 2], "Sum of the vectors does not work")
        
        vector1 = CSVector(array:[1, 1])
        vector2 = CSVector(array:[2, 2, 1, 1])
        
        result = vector1 + vector2
        
        XCTAssertEqual(result.rawValue, [3, 3], "Sum of the vectors does not work")
        
        vector1 = CSVector(array:[1, 1, 3, 3]).slice(start: 0, end: 2)
        vector2 = CSVector(array:[2, 2, 1, 1])
        
        result = vector1 + vector2
        
        XCTAssertEqual(result.rawValue, [3, 3, 4], "Sum of the vectors does not work")
        
        vector1 = CSVector(array:[1, 1, 3, 3]).slice(start: 0, end: 0)
        vector2 = CSVector(array:[2, 2, 1, 1])
        
        result = vector1 + vector2
        
        XCTAssertEqual(result.rawValue, [3], "Sum of the vectors does not work")
        
        vector1 = CSVector(array:[1, 5, 3, 3]).slice(start: 0, end: 3)
        vector2 = CSVector(array:[2, 2, 1, 1])
        
        result = vector1 + vector2
        
        XCTAssertEqual(result.rawValue, [3, 7, 4, 4], "Sum of the vectors does not work")
        
    }
    
    
    func testMathematicalMatrixCalcucaltion() {
        
        var MK = CSMatrix(array: [[1, 1, 1, 1],
                                  [1, 1, 1, 1],
                                  [1, 1, 1, 1],
                                  [1, 1, 1, 1]])
        
        var MO = CSMatrix(array: [[1, 1, 1, 1],
                                  [1, 1, 1, 1],
                                  [1, 1, 1, 1],
                                  [1, 1, 1, 1]])
        
        var result = MK * MO
        
        
        XCTAssertEqual(result.rawValue as NSObject, [[4, 4, 4, 4],
                                                     [4, 4, 4, 4],
                                                     [4, 4, 4, 4],
                                                     [4, 4, 4, 4]] as NSObject, "Multiplicatoin of the matrixes does not work")
        
        MK = CSMatrix(array: [[1, 1, 1, 1],
                              [1, 1, 1, 1],
                              [1, 1, 1, 1],
                              [1, 1, 1, 1]]).slice(start: 0, end: 1)
        
        MO = CSMatrix(array: [[1, 1, 1, 1],
                              [1, 1, 1, 1],
                              [1, 1, 1, 1],
                              [1, 1, 1, 1]])
        
        result = MO * MK
        
        
        XCTAssertEqual(result.rawValue as NSObject, [[4, 4],
                                                     [4, 4],
                                                     [4, 4],
                                                     [4, 4]] as NSObject, "Multiplicatoin of the matrixes does not work")
        
    }
    
    
    
    func testNotParallel1() {
        
        let dataSource = CSDataSource(numberOfProcesses: 4, size: 4)
        
        dataSource.e = 1
        dataSource.c = 1
        dataSource.Z = CSVector(array:[1, 1, 1, 1])
        
        dataSource.MK = CSMatrix(array: [[1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1]])
        
        dataSource.MO = CSMatrix(array: [[1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1]])
        
        dataSource.B = CSVector(array:[1, 1, 1, 1])
        
        
        let am = CSConcurrentTaskManager(dataSource: dataSource)
        
        let result = am.calculateConcurrently()
        XCTAssertEqual(result.rawValue, [17, 17, 17, 17], "Calculation doesnt work")
        
    }
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testNotParallel2() {
        
        
        let am = CSConcurrentTaskManager(dataSource: dataSource2)
        
        let result = am.calculateConcurrently()
        XCTAssertEqual(result.rawValue, [190, 190, 190, 204], "Calculation doesnt work")
        
    }
    
    func testNotParallelWithSlices1() {
        
        let am = CSConcurrentTaskManager(dataSource: dataSource2)
        
        let result = am.calculateSeparately()
        XCTAssertEqual(result.rawValue, [190, 190, 190, 204], "Calculation doesnt work")
        
    }
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testNotParallelWithSlices2() {
        
        let am = CSConcurrentTaskManager(dataSource: dataSource1)
        
        let result = am.calculateSeparately()
        XCTAssertEqual(result.rawValue, [1438, 1640, 1814, 2002], "Calculation doesnt work")
        
    }
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testMerging() {
        
        var vectorToMerge = CSVector(array: [1438, 3640, 1814, 2002])
        vectorToMerge.mergeParts(begin: 0, middle: 2, end: 3)
        XCTAssertEqual(vectorToMerge.rawValue, [1438, 1814, 2002, 3640], "Merging doesnt work")
        
        
        vectorToMerge = CSVector(array: [1, 4, 6, 7, 3, 5, 8, 200])
        vectorToMerge.mergeParts(begin: 0, middle: 4, end: 7)
        XCTAssertEqual(vectorToMerge.rawValue, [1, 3, 4, 5, 6, 7, 8, 200], "Merging doesnt work")
        
    }
    
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testParallel1() {
        
        let dataSource1 = CSDataSource(numberOfProcesses: 2, size: 4)
        
        dataSource1.e = 2
        dataSource1.c = 1
        
        dataSource1.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource1.MO = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.MK = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.B = CSVector(array:[1, 1008, 1, 1])
        
        let am = CSParallelTaskManager(dataSource: dataSource1)
        
        let result = am.calculateParallel()
        XCTAssertEqual(result.rawValue, [1438, 1814, 2002, 3640], "Calculation doesnt work")
        
    }
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testParallel2() {
        
        let dataSource1 = CSDataSource(numberOfProcesses: 3, size: 4)
        
        dataSource1.e = 2
        dataSource1.c = 1
        
        dataSource1.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource1.MO = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.MK = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.B = CSVector(array:[1, 1008, 1, 1])
        
        let am = CSParallelTaskManager(dataSource: dataSource1)
        
        let result = am.calculateParallel()
        XCTAssertEqual(result.rawValue, [1438, 1814, 2002, 3640], "Calculation doesnt work")
        
    }
    
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testParallel3() {
        
        let dataSource1 = CSDataSource(numberOfProcesses: 4, size: 4)
        
        dataSource1.e = 2
        dataSource1.c = 1
        
        dataSource1.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource1.MO = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.MK = CSMatrix(array: [[1, 2, 3, 4],
                                          [5, 6, 7, 8],
                                          [9, 10, 11, 12],
                                          [13, 14, 15, 16]])
        
        dataSource1.B = CSVector(array:[1, 1008, 1, 1])
        
        let am = CSParallelTaskManager(dataSource: dataSource1)
        
        let result = am.calculateParallel()
        XCTAssertEqual(result.rawValue, [1438, 1814, 2002, 3640], "Calculation doesnt work")
        
    }
    
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testParallel4() {
        
        let n = 1600
        let i = 8
        //        for i in 2..<n {
        let dataSource1 = CSDataSource(numberOfProcesses: i, size: n)
        
        dataSource1.randomizeAll()
        
        var concurrentResult:CSVector!
        var result:CSVector!
        
//        self.measure {
//            let concurrentlManager = CSConcurrentTaskManager(dataSource: dataSource1)
//            concurrentResult = concurrentlManager.calculateConcurrently()
//        }
    
        self.measure {
            let parallelManager = CSParallelTaskManager(dataSource: dataSource1)
            result = parallelManager.calculateParallel()
        }
        
        
        XCTAssertEqual(result.rawValue.sorted(), result.rawValue, "Calculation doesnt work P = \(i); N = \(n);")
        //        }
        
    }
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

