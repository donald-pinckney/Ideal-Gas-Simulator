//
//  RectangularContainerNode.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/13/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import SceneKit

class RectangularContainerNode: SCNNode {
    
    let LINE_WIDTH = 0.02
    
    let container: RectangularContainer
    
    let lineNode: SCNNode
    let particleNode: SCNNode
    
    required init(r: RectangularContainer) {
        let dimens = r.dimens.count
        assert(dimens <= 3, "Can't visualize more than 3 dimensions")
        
        container = r
        lineNode = SCNNode()
        particleNode = SCNNode()
        super.init()
        r.node = self
        
        var lx = 0.0
        var ly = 0.0
        var lz = 0.0
        
        if dimens >= 1 {
            lx = r.dimens[0]
        }
        if dimens >= 2 {
            ly = r.dimens[1]
        }
        if dimens >= 3 {
            lz = r.dimens[2]
        }

        let xLineGeom = SCNBox(width: CGFloat(lx + LINE_WIDTH), height: CGFloat(LINE_WIDTH), length: CGFloat(LINE_WIDTH), chamferRadius: 0)
        xLineGeom.firstMaterial!.diffuse.contents = UIColor.whiteColor()
        let yLineGeom = SCNBox(width: CGFloat(LINE_WIDTH), height: CGFloat(ly + LINE_WIDTH), length: CGFloat(LINE_WIDTH), chamferRadius: 0)
        yLineGeom.firstMaterial!.diffuse.contents = UIColor.whiteColor()
        let zLineGeom = SCNBox(width: CGFloat(LINE_WIDTH), height: CGFloat(LINE_WIDTH), length: CGFloat(lz + LINE_WIDTH), chamferRadius: 0)
        zLineGeom.firstMaterial!.diffuse.contents = UIColor.whiteColor()
        
        // X:
        let x0 = SCNNode(geometry: xLineGeom)
        x0.position = SCNVector3(x: 0, y: Float(ly / 2.0), z: Float(lz / 2.0))
        let x1 = SCNNode(geometry: xLineGeom)
        x1.position = SCNVector3(x: 0, y: -Float(ly / 2.0), z: Float(lz / 2.0))
        let x2 = SCNNode(geometry: xLineGeom)
        x2.position = SCNVector3(x: 0, y: -Float(ly / 2.0), z: -Float(lz / 2.0))
        let x3 = SCNNode(geometry: xLineGeom)
        x3.position = SCNVector3(x: 0, y: Float(ly / 2.0), z: -Float(lz / 2.0))

        // Y:
        let y0 = SCNNode(geometry: yLineGeom)
        y0.position = SCNVector3(x: Float(ly / 2.0), y: 0, z: Float(lz / 2.0))
        let y1 = SCNNode(geometry: yLineGeom)
        y1.position = SCNVector3(x: -Float(ly / 2.0), y: 0, z: Float(lz / 2.0))
        let y2 = SCNNode(geometry: yLineGeom)
        y2.position = SCNVector3(x: -Float(ly / 2.0), y: 0, z: -Float(lz / 2.0))
        let y3 = SCNNode(geometry: yLineGeom)
        y3.position = SCNVector3(x: Float(ly / 2.0), y: 0, z: -Float(lz / 2.0))

        // Z:
        let z0 = SCNNode(geometry: zLineGeom)
        z0.position = SCNVector3(x: Float(ly / 2.0), y: Float(lz / 2.0), z: 0)
        let z1 = SCNNode(geometry: zLineGeom)
        z1.position = SCNVector3(x: -Float(ly / 2.0), y: Float(lz / 2.0), z: 0)
        let z2 = SCNNode(geometry: zLineGeom)
        z2.position = SCNVector3(x: -Float(ly / 2.0), y: -Float(lz / 2.0), z: 0)
        let z3 = SCNNode(geometry: zLineGeom)
        z3.position = SCNVector3(x: Float(ly / 2.0), y: -Float(lz / 2.0), z: 0)

        position = cartToSCNVector3(Cartesian(0, 0, 0))
        lineNode.position = cartToSCNVector3(Cartesian(0, 0, 0))
        particleNode.position = cartToSCNVector3(Cartesian(0, 0, 0))

        lineNode.addChildNode(x0)
        lineNode.addChildNode(x1)
        lineNode.addChildNode(x2)
        lineNode.addChildNode(x3)
        
        lineNode.addChildNode(y0)
        lineNode.addChildNode(y1)
        lineNode.addChildNode(y2)
        lineNode.addChildNode(y3)
        
        lineNode.addChildNode(z0)
        lineNode.addChildNode(z1)
        lineNode.addChildNode(z2)
        lineNode.addChildNode(z3)
        
        addChildNode(lineNode)
        addChildNode(particleNode)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Warning: Expensive!
    func updateParticleList() {
        for c: ParticleNode in particleNode.childNodes as [ParticleNode] {
            let p: Particle = c.particle
            var found = false
            for op in container.particles {
                if p === op {
                    found = true
                    break
                }
            }
            
            if !found {
                c.removeFromParentNode()
            }
        }
        
        for p in container.particles {
            var found = false
            for c in particleNode.childNodes as [ParticleNode] {
                if p === c.particle {
                    found = true
                    break
                }
            }
            
            if !found {
                particleNode.addChildNode(ParticleNode(particle: p))
            }
        }
    }
}