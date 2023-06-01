//
//  SignupViewController.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import UIKit

class SignupViewController: UIViewController {

    var styling = UIStyling()
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styling.customizeButton(for: signupButton, color: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor, cornerRadius: 25)
        
        styling.customizeTextFields(for: [usernameTextField, emailTextField, passwordTextField], cornerRadius: 25, borderWidth: 2.0, borderColor: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor)
    }

    
}
