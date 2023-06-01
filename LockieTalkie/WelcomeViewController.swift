//
//  WelcomeViewController.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    var styling = UIStyling()
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var chatTitleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        styling.customizeButtons(for: [loginButton, signupButton], borderWidth: 2.0, color: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor, cornerRadius: 25)
        
        logoImageView.alpha = 0
        chatTitleLabel.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.4, animations: {
                self.logoImageView.alpha = 1
                self.chatTitleLabel.alpha = 1
            })
        }
        
    }
    
}
