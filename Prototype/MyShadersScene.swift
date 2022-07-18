//
//  MyShadersScene.swift
//  Prototype
//
//  Created by 菅井ゆり佳 on 2022/07/18.
//

import SceneKit
import Metal

final class MyShadersScene: SCNScene {
    
    private lazy var startTime = Date()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let cubeNode = SCNNode(geometry: cube)
        
        
        let program = SCNProgram()

        program.vertexFunctionName = "vertexShader"
        program.fragmentFunctionName = "fragmentShader"

        if let material = cubeNode.childNodes.first?.geometry?.firstMaterial {
            material.program = program
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true, block: { (timer) in
            var time = Float(Date().timeIntervalSince(self.startTime))
            let timeData = Data(bytes: &time, count: MemoryLayout<Float>.size)
            cubeNode.geometry?.firstMaterial?.setValue(timeData, forKey: "time")
        })
        
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.red
        
//        cubeNode.childNodes.first?.geometry?.firstMaterial?.program = program
        
//        guard let material = cubeNode.geometry?.firstMaterial else {return}
        

        
//        cube.materials = [material]
//
//        let program = SCNProgram()
//        program.vertexFunctionName = "textureSamplerVertex"
//        program.fragmentFunctionName = "textureSamplerFragment"
//        cubeNode.geometry?.firstMaterial?.program = program
//
//        guard let landscapeImage  = UIImage(named: "catSample") else {
//          return
//        }
//        let materialProperty = SCNMaterialProperty(contents: landscapeImage)
//        cubeNode.geometry?.firstMaterial?.setValue(materialProperty, forKey: "customTexture")
        
        cubeNode.position = SCNVector3(0, 0, 0)
        rootNode.addChildNode(cubeNode)

    }

}

