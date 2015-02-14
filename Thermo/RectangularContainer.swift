//
//  RectangularContainer.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import Foundation

class RectangularContainer {
    
    let lx: Double
    let ly: Double
    let lz: Double
    var N: Int = 100 {
        didSet {
            setupParticles(oldValue)
        }
    }
    
    weak var node: RectangularContainerNode? = nil {
        didSet {
            redraw()
        }
    }
    
    var particles: [Particle] = []
    
    init(lx: Double, ly: Double, lz: Double) {
        self.lx = lx
        self.ly = ly
        self.lz = lz
        
        setupParticles(0)
    }
    
    convenience init() {
        self.init(lx: 1, ly: 1, lz: 1)
    }
    
    func setupParticles(oldN: Int) {
        if N < oldN {
            (oldN - N).times {
                self.particles.removeLast()
            }
        } else {
            (N - oldN).times {
                self.particles.append(Particle(rx: self.lx, ry: self.ly, rz: self.lz))
            }
        }
        
        redraw()
    }
    
    // Force removes and updates all particle nodes. Expensive!
    func redraw() {
        node?.updateParticleList()
    }
    
    
    func update(dt: Double) {
        for p in particles {
            p.pos += dt * p.v
            
            // Reflect collisions until fully within container
            while true {
                var inside = true
                if p.pos.x >= lx/2 || p.pos.x <= -lx/2 {
                    p.v.x *= -1
                    p.pos.x = p.pos.x > 0 ? lx - p.pos.x : -lx - p.pos.x
                    inside = false
                }
                
                if p.pos.y >= ly/2 || p.pos.y <= -ly/2 {
                    p.v.y *= -1
                    p.pos.y = p.pos.y > 0 ? ly - p.pos.y : -ly - p.pos.y
                    inside = false
                }
                
                if p.pos.z >= lz/2 || p.pos.z <= -lz/2 {
                    p.v.z *= -1
                    p.pos.z = p.pos.z > 0 ? lz - p.pos.z : -lz - p.pos.z
                    inside = false
                }
                
                if inside {
                    break
                }
            }
            
            
            p.redraw()
        }
    }
}
