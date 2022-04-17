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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "doraemon_bye_arkit")!
        
        // Allow user to manipulate camera
        sceneView.allowsCameraControl = true
        
        // Allow user translate image
//        sceneView.cameraControlConfiguration.allowsTranslation = true
        
        // Set background color
        sceneView.backgroundColor = UIColor.darkGray
        
        // Set the scene to the view
        sceneView.scene = scene
        
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
