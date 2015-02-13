//
//  Utils.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import SceneKit


typealias Cartesian = (x: Double, y: Double, z: Double)

func cartToSCNVector3(c: Cartesian) -> SCNVector3 {
    return SCNVector3(x: Float(c.x), y: Float(c.y), z: Float(c.z))
}

func *(lhs: Double, rhs: Cartesian) -> Cartesian {
    return (lhs*rhs.x, lhs*rhs.y, lhs*rhs.z)
}

func *(lhs: Cartesian, rhs: Double) -> Cartesian {
    return (lhs.x*rhs, lhs.y*rhs, lhs.z*rhs)
}

func +(lhs: Cartesian, rhs: Cartesian) -> Cartesian {
    return (lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

func +=(inout lhs: Cartesian, rhs: Cartesian) {
    lhs = lhs + rhs
}