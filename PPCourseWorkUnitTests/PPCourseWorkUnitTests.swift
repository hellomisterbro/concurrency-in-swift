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
    
    override func setUp() {
        super.setUp()
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
        
        result = MK * MO
        
        
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
        
        
        let am = CSTaskManager(dataSource: dataSource)
        
        let result = am.calculate()
         XCTAssertEqual(result.rawValue, [17, 17, 17, 17], "Calculation doesnt work")
       
    }
    
        //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testNotParallel2() {
        
        let dataSource = CSDataSource(numberOfProcesses: 1, size: 4)
        
        dataSource.e = 2
        dataSource.c = 1
        
        dataSource.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource.MO = CSMatrix(array: [[1, 2, 3, 4],
                                         [5, 6, 7, 8],
                                         [9, 10, 11, 12],
                                         [13, 14, 15, 16]])
        
        dataSource.MK = CSMatrix(array: [[1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1]])
        
        dataSource.B = CSVector(array:[1, 8, 1, 1])
        
        
        let am = CSTaskManager(dataSource: dataSource)
        
        let result = am.calculate()
        XCTAssertEqual(result.rawValue, [190, 190, 190, 204], "Calculation doesnt work")
        
    }
    
    func testNotParallelWithSlices1() {
        
        let dataSource = CSDataSource(numberOfProcesses: 4, size: 4)
        
        dataSource.e = 2
        dataSource.c = 1
        
        dataSource.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource.MO = CSMatrix(array: [[1, 2, 3, 4],
                                         [5, 6, 7, 8],
                                         [9, 10, 11, 12],
                                         [13, 14, 15, 16]])
        
        dataSource.MK = CSMatrix(array: [[1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1],
                                         [1, 1, 1, 1]])
        
        dataSource.B = CSVector(array:[1, 8, 1, 1])
        
        
        let am = CSTaskManager(dataSource: dataSource)
        
        let result = am.calculateSeparately() 
        XCTAssertEqual(result.rawValue, [190, 190, 190, 204], "Calculation doesnt work")
        
    }
    
    //Assignment: A = sort(e * B + c * Z *(MO * MK))
    func testNotParallelWithSlices2() {
        
        let dataSource = CSDataSource(numberOfProcesses: 4, size: 4)
        
        dataSource.e = 2
        dataSource.c = 1
        
        dataSource.Z = CSVector(array:[1, 3, 1, 1])
        
        dataSource.MO = CSMatrix(array: [[1, 2, 3, 4],
                                         [5, 6, 7, 8],
                                         [9, 10, 11, 12],
                                         [13, 14, 15, 16]])
        
        dataSource.MK = CSMatrix(array: [[1, 2, 3, 4],
                                         [5, 6, 7, 8],
                                         [9, 10, 11, 12],
                                         [13, 14, 15, 16]])
        
        dataSource.B = CSVector(array:[1, 8, 1, 1])
        
        
        let am = CSTaskManager(dataSource: dataSource)
        
        let result = am.calculateSeparately()
        XCTAssertEqual(result.rawValue, [1438, 1640, 1814, 2002], "Calculation doesnt work")
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

func ==<Element : Equatable> (lhs: [[Element]], rhs: [[Element]]) -> Bool {
    return lhs.elementsEqual(rhs, by: ==)
}

