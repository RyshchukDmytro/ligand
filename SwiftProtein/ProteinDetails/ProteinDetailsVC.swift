//
//  ProteinDetailsVC.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit
import SceneKit

class ProteinDetailsVC: UIViewController {
    
    // MARK: - Properties
    private var proteinScene: SCNView!
    private var currentNode: SCNNode?
    private var previousNodeColor: UIColor?
    private var atomDescriptionLabel = UILabel()
    var pdbFile: String?
    var name: String?
    
    // MARK: - ViewCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        proteinScene = SCNView(frame: self.view.frame)
        proteinScene.backgroundColor = .white
        proteinScene.allowsCameraControl = true
        proteinScene.showsStatistics = true
        guard let pdbFile = pdbFile else { return }
        proteinScene.scene = ProteinScene(pdbFile: pdbFile)
        self.view.addSubview(proteinScene)
        navigationItem.title = name
        // like a Viber Big Name 
        navigationItem.largeTitleDisplayMode = .always
        
        atomDescriptionLabel = UILabel(frame: CGRect(x: view.frame.width - 20, y: view.frame.height - 60, width: 20, height: 50))
        atomDescriptionLabel.textColor = .green
        self.view.addSubview(atomDescriptionLabel)
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let add = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [share, add]
    }
    
    // MARK: - Functions
    @objc func shareTapped() {
        let share = proteinScene.snapshot()
        let proteinName = navigationItem.title ?? ""
        let message = NSLocalizedString("This is protein: ", comment: "")  + proteinName
        let activityVC = UIActivityViewController(activityItems: [share, message], applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    @objc func addTapped() {
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebVC") as! WebVC
        webView.proteinName = navigationItem.title ?? "10r"
        navigationController?.pushViewController(webView, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let hitTouch = touches.first else { return }
        
        let location = hitTouch.location(in: proteinScene)
        let hitList = proteinScene.hitTest(location, options: nil)
        
        DispatchQueue.main.async {
            guard let hitNode = hitList.first?.node, hitNode.name != "CONECT" else {
                print("Select node change color: ")
                self.currentNode?.geometry?.firstMaterial?.diffuse.contents = self.previousNodeColor
                return
            }
            if touches.count == 1 {
                self.currentNode?.geometry?.firstMaterial?.diffuse.contents = self.previousNodeColor
                self.currentNode = hitNode
                self.previousNodeColor = hitNode.geometry?.firstMaterial?.diffuse.contents as? UIColor
                self.currentNode?.geometry?.firstMaterial?.diffuse.contents = self.previousNodeColor?.withAlphaComponent(0.5)
                                
                print("Select node: \(hitNode.name)")
                self.atomDescriptionLabel.text = hitNode.name ?? ""
                self.atomDescriptionLabel.textColor = self.previousNodeColor
            }
        }
    }
}
