//
//  Utils.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import SceneKit


struct Cartesian: Printable {
    var x: [Double]
    let N: Int
    
    init(N: Int) {
        self.N = N
        x = Array(count: N, repeatedValue: 0)
    }
    
    init(_ x: Double, _ y: Double, _ z: Double) {
        self.init(N: 3)
        self.x[0] = x
        self.x[1] = y
        self.x[2] = z
    }
    
    init(_ x: Double, _ y: Double) {
        self.init(N: 2)
        self.x[0] = x
        self.x[1] = y
    }
    
    init(_ x: Double) {
        self.init(N: 1)
        self.x[0] = x
    }
    
    var description: String {
        return join(", ", x.map { $0.description })
    }
}

func cartToSCNVector3(c: Cartesian) -> SCNVector3 {
    if c.N == 3 {
        return SCNVector3(x: Float(c.x[0]), y: Float(c.x[1]), z: Float(c.x[2]))
    } else if c.N == 2 {
        return SCNVector3(x: Float(c.x[0]), y: Float(c.x[1]), z: 0)
    } else if c.N == 1 {
        return SCNVector3(x: Float(c.x[0]), y: 0, z: 0)
    } else if c.N == 0 {
        return SCNVector3(x: 0, y: 0, z: 0)
    } else {
        return SCNVector3(x: Float(c.x[0]), y: Float(c.x[1]), z: Float(c.x[2]))
    }
}

func *(lhs: Double, var rhs: Cartesian) -> Cartesian {
    for i in 0..<rhs.N {
        rhs.x[i] *= lhs
    }
    return rhs
}

func *(lhs: Cartesian, rhs: Double) -> Cartesian {
    return rhs * lhs
}

func /(lhs: Cartesian, rhs: Double) -> Cartesian {
    return (1/rhs) * lhs
}

func dot(lhs: Cartesian, rhs: Cartesian) -> Double {
    assert(lhs.N == rhs.N, "Cannot dot vectors of non-matching length")
    var dot = 0.0
    for i in 0..<lhs.N {
        dot += lhs.x[i] * rhs.x[i]
    }
    return dot
}

func +(var lhs: Cartesian, rhs: Cartesian) -> Cartesian {
    assert(lhs.N == rhs.N, "Cannot add vectors of non-matching length")

    for i in 0..<lhs.N {
        lhs.x[i] += rhs.x[i]
    }
    return lhs
}

func +=(inout lhs: Cartesian, rhs: Cartesian) {
    lhs = lhs + rhs
}

func -(lhs: Cartesian, rhs: Cartesian) -> Cartesian {
    return lhs + -rhs
}

prefix func - (rhs: Cartesian) -> Cartesian {
    return -1 * rhs
}

func -=(inout lhs: Cartesian, rhs: Cartesian) {
    lhs = lhs - rhs
}

func mag(c: Cartesian) -> Double {
    return sqrt(magSquare(c))
}

func magSquare(c: Cartesian) -> Double {
    var sum = 0.0
    for i in 0..<c.N {
        sum += pow(c.x[i], 2)
    }
    return sum
}

func distSquare(inout lhs: Cartesian, inout rhs: Cartesian) -> Double {
    assert(lhs.N == rhs.N, "Cannot subtract vectors of non-matching length")
    var D = 0.0
    let a0 = lhs.x
    let a1 = rhs.x
    for i in 0..<lhs.N {
        let v = a0[i] - a1[i]
        D += v * v
    }
    return D
}

func norm(c: Cartesian) -> Cartesian {
    let len = mag(c)
    if len > 0.00001 {
        return c / len
    } else {
        return Cartesian(N: c.N)
    }
}

func == (lhs: Cartesian, rhs: Cartesian) -> Bool
{
    if lhs.N != rhs.N {
        return false
    }
    
    for i in 0..<lhs.N {
        if abs(lhs.x[i] - rhs.x[i]) > 0.00001 {
            return false
        }
    }
    return true
}