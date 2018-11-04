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
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmationTextField.delegate = self
        
        registerButton.layer.cornerRadius = 16
        registerButton.clipsToBounds = true
    }
    
    @IBAction func completeRegistration(_ sender: Any) {
        if (usernameTextField.hasText && emailTextField.hasText && passwordTextField.hasText && confirmationTextField.hasText) {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let confirmation = confirmationTextField.text!
            
            if (password == confirmation && password.count >= 6) {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        print("Error attempting to register user: \(error.localizedDescription)")
                    } else {
                        self.performSegue(withIdentifier: "registerToMain", sender: self)
                    }
                }
            } else {
                generateAlert(alertTitle: "Password", alertMessage: "The password must be at least 6 characters long and match the password confirmation")
            }
        } else {
            generateAlert(alertTitle: "Missing Information", alertMessage: "Please ensure you enter all required information")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "registerToMain") {
            let destinationViewController = segue.destination as! UITabBarController
        }
    }
    
    func generateAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in alert.dismiss (animated: true, completion: nil )}))
        self.present(alert, animated: true, completion: nil)
    }
}
