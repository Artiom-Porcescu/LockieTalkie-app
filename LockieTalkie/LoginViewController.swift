//
//  LoginViewController.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {
    
    var styling = UIStyling()
    var loginUserDefaults = UserDefaults.standard
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styling.customizeButton(for: loginButton, borderWidth: 2.0, color: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor, cornerRadius: 25)
        
        styling.customizeTextFields(for: [emailTextField, passwordTextField], cornerRadius: 25, borderWidth: 2.0, borderColor: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor)
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Oops", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                } else {
                    self.performSegue(withIdentifier: "goToChatLogged", sender: self)
                }
            }
        }
    }
    
}
