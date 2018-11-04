//  LoginPageViewController.swift
//  bitters
//
//  Created by Kristian Galvan on 10/25/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
//        self.emailTextField.text = "123@bitters.com"
//        self.passwordTextField.text = "123bitters"

        loginButton.layer.cornerRadius = 16
        loginButton.clipsToBounds = true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
            } else if Auth.auth().currentUser != nil {
                print("Successful log in!")
                self.performSegue(withIdentifier: "loginToMain", sender: self)
            }
        }
    }
    
    @IBAction func registerNewAccount(_ sender: Any) {
        performSegue(withIdentifier: "loginToRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMain" {
            let destinationViewController = segue.destination as! UITabBarController
        } else if segue.identifier == "loginToRegister" {
            let destinationViewController = segue.destination as! RegisterViewController
        } else {
            print("Could not find corresponding segue")
        }
    }
}
