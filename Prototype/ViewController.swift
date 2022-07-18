//
//  ViewController.swift
//  Prototype
//
//  Created by 菅井ゆり佳 on 2022/04/16.
//

import UIKit
import SceneKit
import Metal
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: SCNView!
    private lazy var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
//        let scene = SCNScene(named: "doraemon")!
        
//        let scene = MyShadersScene()
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        // Set background color
        sceneView.backgroundColor = UIColor.darkGray
        
        
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let cubeNode = SCNNode(geometry: cube)
        
        
        let program = SCNProgram()

        program.vertexFunctionName = "vertexShader"
        program.fragmentFunctionName = "fragmentShader"
        
//        if let material = cubeNode.childNodes.first?.geometry?.firstMaterial {
//            material.program = program
//            print("ok")
//        }

//        cubeNode.childNodes.first?.geometry?.firstMaterial?.program = program
        
        cubeNode.geometry?.firstMaterial?.program = program
        
        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true, block: { (timer) in
            self.updateTime(node: cubeNode)
        })
        
        cubeNode.position = SCNVector3(0, 0, 0)
        scene.rootNode.addChildNode(cubeNode)
        
        guard let camera = sceneView.pointOfView else {
            return
        }
        camera.position = SCNVector3(0, 0, 4)
    
        // Allow user to manipulate camera
        sceneView.allowsCameraControl = true
        
        // Allow user translate image
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
    }
    
    private func updateTime(node: SCNNode) {
        var time = Float(Date().timeIntervalSince(startTime))
        let timeData = Data(bytes: &time, count: MemoryLayout<Float>.size)
        node.geometry?.firstMaterial?.setValue(timeData, forKey: "time")
    }

}
