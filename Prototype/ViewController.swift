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

    @IBOutlet var sceneView: SCNView!
    
    private var newAngleY :Float = 0.0
    private var currentAngleY :Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "doraemon")!
        
        // Set background color
        sceneView.backgroundColor = UIColor.darkGray
        
        guard let Node = scene.rootNode.childNode(withName: "parentNode", recursively: true) else {
            return
        }
        
        guard let camera = sceneView.pointOfView else {
            return
        }
        let cameraPos = SCNVector3Make(0, 0, -0.5)
        let position = camera.convertPosition(cameraPos, to: nil)
        
        Node.position = position
        
        // Set the scene to the view
        sceneView.scene = scene
        
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
                    
                    self.newAngleY = Float(translation.x) * (Float) (Double.pi)/270
                    self.newAngleY += self.currentAngleY
                    parentNode.eulerAngles.y = self.newAngleY
                    
                }
                
            }
            
        }
        else if recognizer.state == .ended {
            self.currentAngleY = self.newAngleY
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
