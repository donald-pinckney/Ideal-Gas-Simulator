//
//  GameViewController.swift
//  Thermo
//
//  Created by Donald Pinckney on 2/12/15.
//  Copyright (c) 2015 donald. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var labelN: UILabel!
    
    var container: RectangularContainer!
    var lastTime: NSTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        
        // retrieve the SCNView
        let scnView = self.sceneView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        container = RectangularContainer(lx: 1, ly: 1, lz: 1)
        let containerNode = RectangularContainerNode(r: container)
        scene.rootNode.addChildNode(containerNode)
        
        scnView.delegate = self
        scnView.playing = true
        
        
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        scnView.addGestureRecognizer(pan)
    }
    
    func renderer(aRenderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval) {
        // per-frame code here
        let dt = time - lastTime
        if dt < 0.1 {
            container.update(dt)
        }
        lastTime = time
    }
    
    func pan(pan: UIPanGestureRecognizer) {
        container?.node?.eulerAngles.y += 0.005 * Float(pan.translationInView(view).x)
        pan.setTranslation(CGPoint.zeroPoint, inView: view)
    }
    
    @IBAction func sliderNChanged(sender: UISlider) {
        var N = Int(round(sender.value))
        
        labelN.text = "N = \(N)"
        container.N = N
    }
}
