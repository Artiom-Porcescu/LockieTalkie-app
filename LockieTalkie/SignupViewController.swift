//
//  SignupViewController.swift
//  LockieTalkie
//
//  Created by Artiom Porcescu on 31.05.2023.
//

import UIKit
import FirebaseStorage
import Photos
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class SignupViewController: UIViewController {

    var styling = UIStyling()
    let storage = Storage.storage()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        styling.customizeButton(for: signupButton, color: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor, cornerRadius: 25)
        
        styling.customizeTextFields(for: [userNameTextField, emailTextField, passwordTextField], cornerRadius: 25, borderWidth: 2.0, borderColor: UIColor(red: 0.72, green: 0.85, blue: 0.99, alpha: 1.0).cgColor)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        tapToChangeButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        checkPermissions()
        
        errorLabel.text = ""
    }
    
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status:
                PHAuthorizationStatus) -> Void in
                ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("Have authorization")
        } else {
            print("Authorization declined")
        }
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
            guard let username = self.userNameTextField.text, username.count > 3 else {
                self.errorLabel.text = "Please enter a valid username"
                return
            }

            guard let password = passwordTextField.text else {
                self.errorLabel.text = "Please enter a valid password"
                return
            }

            guard let email = emailTextField.text else {
                self.errorLabel.text = "Please enter a valid email"
                return
            }

        guard let image = profileImageView.image else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Oops", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                } else {
                    self.uploadToCloud(with: image)
                    //Navigate to the ChatViewController
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["username": username, "uid": authResult!.user.uid]) { (error) in
                        if let e = error {
                            let alert = UIAlertController(title: "Oops", message: e.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            return
                        } else {
                            self.performSegue(withIdentifier: "goToChat", sender: self)
                        }
                    }
                }
            }
        }
    
    func uploadToCloud(with profileImage:UIImage) {

    let storage = Storage.storage().reference()
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard  let imageData = profileImage.jpegData(compressionQuality: 0.75) else {
        return
    }
        
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
        
        storage.child("users/\(uid).jpg").putData(imageData, metadata: metaData) { (StorageMetadata, error) in
        guard StorageMetadata != nil else{
            print("oops an error occured while data uploading")
            return
        }
             print("Image sent")
        }
        
    }

    
}

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
