//
//  Particle.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import Foundation

class Particle {
    let m: Double
    let r: Double
    
    var pos: Cartesian
    var v: Cartesian
    
    weak var node: ParticleNode? = nil
    
    convenience init(rx: Double, ry: Double, rz: Double) {
        
        let vRange = 1.0
        self.init(m: 1, r: 0.02, pos: (Double.random(min: -rx/2, max: rx/2), Double.random(min: -ry/2, max: ry/2), Double.random(min: -rz/2, max: rz/2)),
                                  v: (Double.random(min: -vRange, max: vRange), Double.random(min: -vRange, max: vRange), Double.random(min: -vRange, max: vRange)))
    }
    
    init(m: Double, r: Double, pos: Cartesian, v: Cartesian) {
        self.m = m
        self.pos = pos
        self.v = v
        self.r = r
    }

    func redraw() {
        node?.update()
    }
}
