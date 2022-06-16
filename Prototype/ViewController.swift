//
//  ViewController.swift
//  Prototype
//
//  Created by 菅井ゆり佳 on 2022/04/16.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var newAngleX :Float = 0.0
    private var newAngleY :Float = 0.0
    private var newAngleZ :Float = 0.0
    private var currentAngleX :Float = 0.0
    private var currentAngleY :Float = 0.0
    private var currentAngleZ :Float = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        
        let scene = SCNScene(named: "doraemon")!
        
//        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        // Set background color
        sceneView.backgroundColor = UIColor.darkGray
        
        /*
        // Make some cubes
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let cubeNode = SCNNode(geometry: cube)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        
        cubeNode.name = "cube"
        cubeNode.geometry?.materials = [material]
        cubeNode.position = SCNVector3(0, 0, 0)
                    
        self.sceneView.scene.rootNode.addChildNode(cubeNode)
        
        guard let camera = sceneView.pointOfView else {
            return
        }
        camera.position = SCNVector3(0, 0, 2)
        */


        guard let Node = scene.rootNode.childNode(withName: "parentNode", recursively: true) else {
            return
        }
        guard let camera = sceneView.pointOfView else {
            return
        }
        let cameraPos = SCNVector3Make(0, 0, -0.5)
        let position = camera.convertPosition(cameraPos, to: nil)
        Node.position = position

        
        // Allow user to manipulate camera
        sceneView.allowsCameraControl = true
        
        // Allow user translate image
//        sceneView.cameraControlConfiguration.allowsTranslation = true
        
        registerGestureRecognizers()
    }
    
    private func registerGestureRecognizers() {
        
//        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
//        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.sceneView.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func panned(recognizer :UIPanGestureRecognizer) {
        
        if recognizer.state == .changed {
            
            guard let sceneView = recognizer.view as? SCNView else {
                return
            }
            
            let touch = recognizer.location(in: sceneView)
            let translation = recognizer.translation(in: sceneView)
            
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                
                if let parentNode = hitTest.node.parent {
                    /*
                    let div = currentAngleY.truncatingRemainder(dividingBy: 6.0)
                    if (div <= 1.5 && div >= 4.5) {
                        self.newAngleX = Float(translation.y) * (Float) (Double.pi)/360
                        self.newAngleX += self.currentAngleX
                        parentNode.eulerAngles.x = self.newAngleX
                    } else {
                        self.newAngleX = Float(translation.y) * (Float) (Double.pi)/360
                        self.newAngleX += self.currentAngleX
                        parentNode.eulerAngles.x = self.newAngleX
                    }
                    
                    self.newAngleY = Float(translation.x) * (Float) (Double.pi)/360
                    self.newAngleY += self.currentAngleY
                    parentNode.eulerAngles.y = self.newAngleY

                    */
                    self.newAngleX = Float(translation.y) * (Float) (Double.pi)/360
                    self.newAngleX += self.currentAngleX
                    parentNode.eulerAngles.x = self.newAngleX
                    
                    self.newAngleY = Float(translation.x) * (Float) (Double.pi)/360
                    self.newAngleY += self.currentAngleY
                    parentNode.eulerAngles.y = self.newAngleY

                    self.newAngleZ = Float(translation.x) * (Float) (Double.pi)/360
                    self.newAngleZ += self.currentAngleZ
                    parentNode.eulerAngles.z = self.newAngleZ
                    
                }
                
            }
            
        }
        else if recognizer.state == .ended {
            self.currentAngleX = self.newAngleX
            self.currentAngleY = self.newAngleY
            self.currentAngleZ = self.newAngleZ
            print(self.currentAngleX)
        }
    }
    
    @objc func pinched(recognizer :UIPinchGestureRecognizer) {
        
        if recognizer.state == .changed {
            
            guard let sceneView = recognizer.view as? SCNView else {
                return
            }
            
            let touch = recognizer.location(in: sceneView)
            
            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
            
            if let hitTest = hitTestResults.first {
                
                let chairNode = hitTest.node
                
                let pinchScaleX = Float(recognizer.scale) * chairNode.scale.x
                let pinchScaleY = Float(recognizer.scale) * chairNode.scale.y
                let pinchScaleZ = Float(recognizer.scale) * chairNode.scale.z
                
                chairNode.scale = SCNVector3(pinchScaleX,pinchScaleY,pinchScaleZ)
                
                recognizer.scale = 1
                
            }
        }
        
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
     */
}
