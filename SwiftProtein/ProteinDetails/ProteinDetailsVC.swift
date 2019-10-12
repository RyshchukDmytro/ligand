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

    override func viewDidLoad() {
        super.viewDidLoad()
        proteinScene = SCNView(frame: self.view.frame)
        proteinScene.backgroundColor = .white
        proteinScene.allowsCameraControl = true
        proteinScene.showsStatistics = true
        
        proteinScene.scene = ProteinScene(pdbFile: tempFunc() ?? "")
        self.view.addSubview(proteinScene)

    }
    func tempFunc() -> String? {
        if let filepath = Bundle.main.path(forResource: "00O_model", ofType: "pdb") {
            do {
                let contents = try String(contentsOfFile: filepath)
                print(contents)
                return contents
            } catch {
                // contents could not be loaded
                return nil
            }
        } else {
            // example.txt not found!
            return nil
        }
    }
}
