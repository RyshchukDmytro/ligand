//
//  LoginVC.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: UIVC {

    // MARK: - Outlets
    @IBOutlet weak var idButton: UIButton!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // MARK: - Properties
    private let context: LAContext = LAContext()
    private var firstEnter = true
    
    // MARK: - ViewCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.placeholder = NSLocalizedString("Login", comment: "")
        passwordTF.placeholder = NSLocalizedString("Password", comment: "")
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            idButton.isHidden = true
        }
        if firstEnter {
            firstEnter = false
            detectTouchId()
        }
    }

    // MARK: - Actions
    @IBAction func touchIdAction(_ sender: UIButton) {
        detectTouchId()
    }
    
    @IBAction func enterWithoutTouchId(_ sender: UIButton) {
        if loginTF.text == "Admin" && passwordTF.text == "Root" {
            goToProteinsListVC()
        } else {
            self.popupAlert(title: "Login or password is incorrect", message: "Try another one", action: "Ok")
        }
    }
    
    // MARK: - Functions
    private func detectTouchId() {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            let reason = NSLocalizedString("We need your touch id to enter you further", comment: "")
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (successful, error) in
                if successful {
                    self.goToProteinsListVC()
                } else {
                    DispatchQueue.main.async {
                        self.popupAlert(title: "Something go wrong", message: "Try one more time", action: "Cancel")
                    }
                }
            }
        }
    }
    
    private func goToProteinsListVC() {
        DispatchQueue.main.async {
            let proteinsListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProteinsListVC") as! ProteinsListVC
            self.navigationController?.pushViewController(proteinsListVC, animated: true)
        }
    }
}
