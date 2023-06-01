//
//  LoginViewController.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var styling = UIStyling()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styling.customizeButton(for: loginButton, borderWidth: 2.0, color: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor, cornerRadius: 25)
        
        styling.customizeTextFields(for: [emailTextField, passwordTextField], cornerRadius: 25, borderWidth: 2.0, borderColor: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor)
    }
    
}
