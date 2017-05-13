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
        
//                dataSource.MK = CSMatrix(array: [[1, 1, 1, 1],
//                                                 [1, 1, 1, 1],
//                                                 [1, 1, 1, 1],
//                                                 [1, 1, 1, 1]])
//        
//                dataSource.MO = CSMatrix(array: [[1, 1, 1, 1],
//                                                 [1, 1, 1, 1],
//                                                 [1, 1, 1, 1],
//                                                 [1, 1, 1, 1]])
        
    }
    
    
    
    
    
    func testExample() {
        let arra = [1, 1, 1, 1]
        let vector1 = CSVector(array:[1, 1, 1, 1])
        let vector2 = CSVector(array:[1, 1, 1, 1])
        //
        let result = vector1 + vector2
        //
        XCTAssertEqual(result.rawValue, [2, 2, 2, 2])
        //
        //        let dataSource = CSDataSource(numberOfProcesses: 4)
        //
        //        dataSource.e = 1
        //        dataSource.c = 1
        //        dataSource.Z = CSVector(array:[1, 1, 1, 1])
        //
        //        dataSource.MK = CSMatrix(array: [[1, 1, 1, 1],
        //                                         [1, 1, 1, 1],
        //                                         [1, 1, 1, 1],
        //                                         [1, 1, 1, 1]])
        //
        //        dataSource.MO = CSMatrix(array: [[1, 1, 1, 1],
        //                                         [1, 1, 1, 1],
        //                                         [1, 1, 1, 1],
        //                                         [1, 1, 1, 1]])
        //
        //        dataSource.B = CSVector(array:[1, 1, 1, 1])
        //
        //
        //        let am = CSTaskManager(dataSource: dataSource)
        //
        //        let result = am.doParallel()
        //
        //        print(result)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
