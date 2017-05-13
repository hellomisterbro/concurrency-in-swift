//
//  main.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/24/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Foundation


let dataSource = CSDataSource(numberOfProcesses: 4)

dataSource.e = 1
dataSource.c = 1
dataSource.Z = CSVector(array:[10, 10, 10, 10])
dataSource.MK = CSMatrix(array: [[10, 10, 10, 10]])
dataSource.MO = CSMatrix(array: [[10, 10, 10, 10]])
dataSource.B = CSVector(array:[10, 10, 10, 10])


let am = CSTaskManager(dataSource: dataSource)

let result = am.doParallel()

print(result)


