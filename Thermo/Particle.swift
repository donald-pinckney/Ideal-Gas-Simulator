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
    var wasOtherParticle: Bool = false

    
    // Core stuff
    let m: Double
    let r: Double
    
    var pos: Cartesian
    var v: Cartesian
    
    weak var node: ParticleNode? = nil
    
    
    convenience init(rx: Double, ry: Double, rz: Double, rs: Double, rm: Double) {
        
        let vRange = 1.0
        let theta = Double.random(min: 0, max: 2*M_PI)
        let phi = Double.random(min: 0, max: M_PI)
        let speed = Double.random(min: 0, max: rs)
        
        let x = speed * sin(phi) * cos(theta)
        let y = speed * sin(phi) * sin(theta)
        let z = speed * cos(phi)
        
        self.init(m: Double.random(min: 0.1, max: rm), pos: Cartesian(Double.random(min: -rx/2, max: rx/2), Double.random(min: -ry/2, max: ry/2), Double.random(min: -rz/2, max: rz/2)),
                                    v: Cartesian(x, y, z))
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
