//
//  main.swift
//  PPCourseWork1
//
//  Created by Nikita Kirichek on 3/24/17.
//  Copyright © 2017 Nikita Kirichek. All rights reserved.
//

import Foundation

print("Hello, World!")

//sort(e∗B + c∗Z∗(MO∗MK))


let am1 = AssignmentManager(process: 0)
let am2 = AssignmentManager(process: 1)

let e = 2
let c = 1
let B = AssignmentManager.randomVector(max: 2)
let Z = AssignmentManager.randomVector(max: 2)
let MO = AssignmentManager.randomMatrix(max: 2)
let MK = AssignmentManager.randomMatrix(max: 2)

am1.e = e
am1.c = c
am1.B = B
am1.Z = Z
am1.MO = MO
am1.MK = MK

am2.e = e
am2.c = c
am2.B = B
am2.Z = Z
am2.MO = MO
am2.MK = MK


var d = AssignmentManager.initVector(count: Config.N)

am1.count(D: &d)
am2.count(D: &d)


let s = d

print("")
