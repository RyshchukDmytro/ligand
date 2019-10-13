//
//  LoginVC.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {

    @IBOutlet weak var idButton: UIButton!
    let context: LAContext = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            idButton.isHidden = true
        }
        detectTouchId()
    }

    @IBAction func touchIdAction(_ sender: UIButton) {
        detectTouchId()
    }
    
    private func detectTouchId() {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your touch id to enter you further") { (successful, error) in
                if successful {
                    print("success")
                    DispatchQueue.main.async {
                        let proteinsListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProteinsListVC") as! ProteinsListVC
                        self.navigationController?.pushViewController(proteinsListVC, animated: true)
                    }
                } else {
                    let alert = UIAlertController(title: "Something go wrong", message: "Try one more time", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
                    self.present(alert, animated: true)
                    print("not success")
                }
            }
        }
    }
}

