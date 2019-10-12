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
    
    var proteinScene: SCNView!
    var pdbFile: String?
    var name: String?

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
    }
}
