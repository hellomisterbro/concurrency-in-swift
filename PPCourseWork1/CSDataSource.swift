//
//  CSDataSource.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 5/11/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Cocoa

class CSDataSource: NSObject {

    var P: Int
    var N: Int
    
    var e: Int?
    var c: Int?
    var Z: CSVector?
    var MK: CSMatrix?
    
    //not shared
    var B: CSVector?
    var MO: CSMatrix?
    
    init(numberOfProcesses: Int, size: Int) {
        P = numberOfProcesses
        N = size
    }
    
    
    func randomizeAll() {
        let randomizer = CSRandomizer(max: 1, size: N)
        
        e = randomizer.randomVar()
        c = randomizer.randomVar()
        Z = randomizer.randomVector()
        B = randomizer.randomVector()
        Z = randomizer.randomVector()
        MK = randomizer.randomMatrix()
        MO = randomizer.randomMatrix()
    }
    
}
