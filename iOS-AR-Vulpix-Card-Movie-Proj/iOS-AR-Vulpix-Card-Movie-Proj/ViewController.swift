//
//  ViewController.swift
//  iOS-AR-Vulpix-Card-Movie-Proj
//
//  Created by Rafael Carvalho on 17/08/22.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        // Criar a referência para o seu "AR Resource Group"
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "PokeCardsResource", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 1
            
            print("--> Sucesso na detecção do AR Resourse Group..")
        } else {
            print("--> Falha na detecção do AR Resourse Group..")
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        // Se reconhecer uma img do seu AR Resource Group:
        if let minhaIMG = anchor as? ARImageAnchor{
            
            print("--> Reconheceu: \(minhaIMG.referenceImage.name)")
            
            //Cria o plane
            let plane = SCNPlane(
                width: minhaIMG.referenceImage.physicalSize.width,
                height: minhaIMG.referenceImage.physicalSize.height
            )
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.8)
            
            //Cria um node e insere o plane nele
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            // Insere o node (que tem o plane) no "node principal".
            node.addChildNode(planeNode)
        }
  
        return node
    }

    
    
    
}
