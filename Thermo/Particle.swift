//
//  Particle.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import Foundation

class Particle: Printable {
    
    // Extra stuff
    var didAlreadyCollide: Bool = false

    
    // Core stuff
    let m: Double
    let r: Double
    
    var pos: Cartesian
    var v: Cartesian
    
    weak var node: ParticleNode? = nil
    

    convenience init(N: Int) {
        
        if N == 3 {
            let rx = 1.0
            let theta = Double.random(min: 0, max: 2*M_PI)
            let phi = Double.random(min: 0, max: M_PI)
            let speed = Double.random(min: 0, max: 2.0)
            
            let x = speed * sin(phi) * cos(theta)
            let y = speed * sin(phi) * sin(theta)
            let z = speed * cos(phi)
            
            self.init(m: Double.random(min: 0.1, max: 5.0), pos: Cartesian(Double.random(min: -rx/2, max: rx/2), Double.random(min: -rx/2, max: rx/2), Double.random(min: -rx/2, max: rx/2)),
                                        v: Cartesian(x, y, z))
        } else if N == 2 {
            let rx = 1.0
            let theta = Double.random(min: 0, max: 2*M_PI)
            let speed = Double.random(min: 0, max: 2.0)
            
            let x = speed * cos(theta)
            let y = speed * sin(theta)
            
            self.init(m: Double.random(min: 0.1, max: 5.0), pos: Cartesian(Double.random(min: -rx/2, max: rx/2), Double.random(min: -rx/2, max: rx/2)),
                v: Cartesian(x, y))
        } else if N == 1 {
            let rx = 1.0
            let speed = Double.random(min: 0, max: 2.0)
            
            self.init(m: Double.random(min: 0.1, max: 5.0), pos: Cartesian(Double.random(min: -rx/2, max: rx/2)),
                v: Cartesian(speed))
        } else {            
            let rx = 1.0
            
            var pos = Cartesian(N: N)
            var v = Cartesian(N: N)
            
            for i in 0..<N {
                pos.x[i] = Double.random(min: -rx/2, max: rx/2)
            }
            for i in 0..<N {
                v.x[i] = Double.random(min: -2.0, max: 2.0)
            }
            
            self.init(m: Double.random(min: 0.1, max: 5.0), pos: pos,
                v: v)
        }
    }
    
    init(m: Double, pos: Cartesian, v: Cartesian) {
        self.m = m
        self.pos = pos
        self.v = v
        self.r = cbrt(m) / 50
    }

    func redraw() {
        node?.update()
    }
    
    var description: String {
        return "P = \(pos);\nv = \(v)"
    }
}
