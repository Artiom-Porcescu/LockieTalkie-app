//
//  ForgotPasswordViewController.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var styling = UIStyling()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styling.customizeButton(for: submitButton, color: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor, cornerRadius: 25)
        
        styling.customizeTextFields(for: [emailTextField], cornerRadius: 25, borderWidth: 2.0, borderColor: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor)
    }
    
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        let auth = Auth.auth()

        auth.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
        if let error = error {
        //self.errorLabel.text = "Please enter a valid email adress"
        let alert = UIAlertController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
        }
        let alert = UIAlertController(title: "Great", message: "A password reset email has been sent", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
