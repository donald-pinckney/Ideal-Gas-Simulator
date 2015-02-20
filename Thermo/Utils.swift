//
//  Utils.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import SceneKit


struct Cartesian: Printable {
    var x, y, z: Double
    
    init(_ x: Double, _ y: Double, _ z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    var description: String {
        return "(\(x), \(y), \(z))"
    }
}

func cartToSCNVector3(c: Cartesian) -> SCNVector3 {
    return SCNVector3(x: Float(c.x), y: Float(c.y), z: Float(c.z))
}

func *(lhs: Double, rhs: Cartesian) -> Cartesian {
    return Cartesian(lhs*rhs.x, lhs*rhs.y, lhs*rhs.z)
}

func *(lhs: Cartesian, rhs: Double) -> Cartesian {
    return Cartesian(lhs.x*rhs, lhs.y*rhs, lhs.z*rhs)
}

func /(lhs: Cartesian, rhs: Double) -> Cartesian {
    return (1/rhs) * lhs
}

func dot(lhs: Cartesian, rhs: Cartesian) -> Double {
    return lhs.x*rhs.x + lhs.y*rhs.y + lhs.z*rhs.z
}

func +(lhs: Cartesian, rhs: Cartesian) -> Cartesian {
    return Cartesian(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

func +=(inout lhs: Cartesian, rhs: Cartesian) {
    lhs = lhs + rhs
}

func -(lhs: Cartesian, rhs: Cartesian) -> Cartesian {
    return Cartesian(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
}

prefix func - (rhs: Cartesian) -> Cartesian {
    return Cartesian(-rhs.x, -rhs.y, -rhs.z)
}

func -=(inout lhs: Cartesian, rhs: Cartesian) {
    lhs = lhs - rhs
}

func mag(c: Cartesian) -> Double {
    return sqrt(c.x * c.x + c.y * c.y + c.z * c.z)
}

func magSquare(c: Cartesian) -> Double {
    return c.x * c.x + c.y * c.y + c.z * c.z
}

func distSquare(lhs: Cartesian, rhs: Cartesian) -> Double {
    let x = (lhs.x - rhs.x) * (lhs.x - rhs.x)
    let y = (lhs.y - rhs.y) * (lhs.y - rhs.y)
    let z = (lhs.z - rhs.z) * (lhs.z - rhs.z)
    return x + y + z
}

func norm(c: Cartesian) -> Cartesian {
    let len = mag(c)
    if len > 0.00001 {
        return (1/len) * c
    } else {
        return Cartesian(0, 0, 0)
    }
}

func == (lhs: Cartesian, rhs: Cartesian) -> Bool
{
    return abs(lhs.x - rhs.x) < 0.0000001 && abs(lhs.y - rhs.y) < 0.0000001 && abs(lhs.z - rhs.z) < 0.0000001
}