//
//  ParticleNode.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import SceneKit

class ParticleNode: SCNNode {
    
    let particle: Particle
    required init(particle p: Particle) {
        particle = p
        super.init()
        p.node = self

        geometry = SCNSphere(radius: CGFloat(p.r))
        position = cartToSCNVector3(p.pos)
        geometry!.firstMaterial!.diffuse.contents = UIColor.redColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        position = cartToSCNVector3(particle.pos)
        geometry?.firstMaterial?.diffuse.contents = UIColor.redColor()
    }
}
