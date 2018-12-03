//  SignUpViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit
import Firebase

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmationTextField.becomeFirstResponder()
        } else {
            confirmationTextField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmationTextField.delegate = self
        setUpUserInterface()
    }
    
    @IBAction func completeRegistration(_ sender: Any) {
        registerButton.isUserInteractionEnabled = false
        
        if (usernameTextField.hasText && emailTextField.hasText && passwordTextField.hasText && confirmationTextField.hasText) {
            
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let confirmation = confirmationTextField.text!
            
            if (password == confirmation && password.count >= 6) {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    self.registerButton.isUserInteractionEnabled = true
                    if let error = error {
                        print("Error registering user: \(error.localizedDescription)")
                        self.generateAlert(alertTitle: "Could Not Register", alertMessage: "There was an error attempting to register your account")
                    } else {
                        print("Successful registration!")
                        self.performSegue(withIdentifier: "registerToMain", sender: self)
                    }
                }
            } else {
                self.registerButton.isUserInteractionEnabled = true
                generateAlert(alertTitle: "Password Mismatch", alertMessage: "Password must be at least 6 characters long and match the password confirmation")
            }
        } else {
            self.registerButton.isUserInteractionEnabled = true
            generateAlert(alertTitle: "Missing Information", alertMessage: "Please enter all required fields")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "registerToMain") {
            _ = segue.destination as! UITabBarController
        }
    }
    
    func generateAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in alert.dismiss (animated: true, completion: nil )}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpUserInterface() {
        passwordTextField.isSecureTextEntry = true
        confirmationTextField.isSecureTextEntry = true
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
    }
}
