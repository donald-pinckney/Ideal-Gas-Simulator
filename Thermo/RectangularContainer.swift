//
//  RectangularContainer.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import Foundation


class RectangularContainer {
    
    let dimens: [Double]
    
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
    
    
    
    // MARK: - Constructors -
    
    init(numDims: Int, squareDimen l: Double) {
        dimens = Array(count: numDims, repeatedValue: l)
        
        setupParticles(0)
    }
    
    convenience init() {
        self.init(numDims: 3, squareDimen: 1)
    }
    
    func setupParticles(oldN: Int) {
        if N < oldN {
            (oldN - N).times {
                self.particles.removeLast()
            }
        } else {
            (N - oldN).times {
                self.particles.append(Particle(N: self.dimens.count))
            }
        }

        redraw()
    }
    
    // Force removes and updates all particle nodes. Expensive!
    func redraw() {
        node?.updateParticleList()
    }
    
    // MARK: - Simulation Update Logic -
    func update(dt: Double) {
        
        for p in particles {
            // Update positions
            moveParticle(p, dt: dt)
            
            // Reflect collisions until fully within container
            collideParticleAndWall(p, dt: dt)
        }
        
        for p in particles {
            // Collide particle with other particles
            if !p.didAlreadyCollide {
                collideParticleAndOtherParticles(p, dt: dt)
            }
            
        }
        
        for p in particles {
            p.didAlreadyCollide = false
            p.redraw()

        }
        
    }
    
    func moveParticle(p: Particle, dt: Double) {
        p.pos += dt * p.v
    }
    
    func collideParticleAndWall(p: Particle, dt: Double) {
        while true {
            var inside = true
            
            for i in 0..<dimens.count {
                let d = dimens[i]
                let pos = p.pos.x[i]
                if pos >= d/2 || pos <= -d/2 {
                    p.v.x[i] *= -1
                    p.pos.x[i] = pos > 0 ? d - pos : -d - pos
                    inside = false
                }
            }
            
            if inside {
                return
            }
        }
    }
    
    func collideParticleAndOtherParticles(p: Particle, dt: Double) {
        // Octrees would be cool, but for now linear search
        
        for op in particles {
            if p === op {
                continue
            }
            
            let D = distSquare(&p.pos, &op.pos)
            
            if D <= pow(p.r + op.r, 2) {
                let n = norm(op.pos - p.pos)
                let d0 = (D + p.r * p.r - op.r * op.r) / (2*sqrt(D)) // distance from center of circle 0 to intersection plane
                let d1 = (D - p.r * p.r + op.r * op.r) / (2*sqrt(D)) // distance from center of circle 1 to intersection plane
                let pPastPlane = p.r - d0
                let opPastPlane = op.r - d1
                
 

                let sectionOfPBadDt = pPastPlane / dot(p.v - op.v, n) * dt
                let sectionOfPGoodDt = (1 - pPastPlane / dot(p.v - op.v, n)) * dt
                
                p.pos = p.pos - sectionOfPBadDt * p.v
                op.pos = op.pos - sectionOfPBadDt * op.v
                
                
                let momentumBefore = p.m*p.v + op.m*op.v
                
                let normalCollisionVPI = dot(p.v, n)
                let normalCollisionVOPI = dot(op.v, n)
                
                 // Calculate final collision velocities, need to implement different masses
                let normalCollisionVPF = (normalCollisionVPI * (p.m - op.m) + 2*op.m*normalCollisionVOPI) / (p.m + op.m)
                let normalCollisionVOPF = (normalCollisionVOPI * (op.m - p.m) + 2*p.m*normalCollisionVPI) / (p.m + op.m)
                
                p.v += (normalCollisionVPF - normalCollisionVPI) * n
                op.v += (normalCollisionVOPF - normalCollisionVOPI) * n
                
                let momentumAfter = p.m*p.v + op.m*op.v

                p.pos = p.pos + sectionOfPGoodDt * p.v
                op.pos = op.pos + sectionOfPGoodDt * op.v
                
                
                
                p.didAlreadyCollide = true
                op.didAlreadyCollide = true
                
                
                assert(momentumBefore == momentumAfter, "Momentum has not been conserved.\nP0 = \(momentumBefore)\nPf = \(momentumAfter)\n")
            }
        }
    }
    
    
    // MARK: - Output Data -
}
