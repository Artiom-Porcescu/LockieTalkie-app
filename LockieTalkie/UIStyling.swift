//
//  UIStyling.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import Foundation
import UIKit

struct UIStyling {
    func customizeTextFields(for textFields: [UITextField], cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        for text_Field in textFields {
            text_Field.layer.cornerRadius = cornerRadius
            text_Field.layer.borderWidth = borderWidth
            text_Field.layer.borderColor = borderColor
            text_Field.layer.masksToBounds = true
        }
    }
    
    func customizeButtons(for buttons: [UIButton], borderWidth: CGFloat, color: CGColor, cornerRadius: CGFloat) {
        
        for button in buttons {
            button.layer.borderWidth = borderWidth
            button.layer.borderColor = color
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
        }
        
    }
    
    func customizeButton(for button: UIButton, borderWidth: CGFloat, color: CGColor, cornerRadius: CGFloat) {
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
    }
    
    func customizeButton(for button: UIButton, color: CGColor, cornerRadius: CGFloat) {
            button.backgroundColor = UIColor(cgColor: color)
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
    }
}
