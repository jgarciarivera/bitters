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
    @IBOutlet weak var registerButton: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Automatically populate text fields with login info. For development purposes only
        self.emailTextField.text = "123@bitters.com"
        self.passwordTextField.text = "123bitters"
        
        showDiscoverIfUserLoggedIn()
        setUpUserInterface()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        loginButton.isUserInteractionEnabled = false
        
        if (emailTextField.hasText && passwordTextField.hasText) {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                self.loginButton.isUserInteractionEnabled = true
                if error != nil {
                    print("Error logging in")
                    self.generateAlert(alertTitle: "Could Not Login", alertMessage: "Please ensure the login credentials are correct")
                } else if Auth.auth().currentUser != nil {
                    print("Successful log in!")
                    self.performSegue(withIdentifier: "loginToMain", sender: self)
                }
            }
        } else {
            self.loginButton.isUserInteractionEnabled = true
            self.generateAlert(alertTitle: "Missing Credentials", alertMessage: "Please enter all required fields")
        }
    }
    
    func generateAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in alert.dismiss (animated: true, completion: nil )}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerNewAccount(_ sender: Any) {
        registerButton.isUserInteractionEnabled = false
        performSegue(withIdentifier: "loginToRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMain" {
            _ = segue.destination as! UITabBarController
        } else if segue.identifier == "loginToRegister" {
            _ = segue.destination as! RegisterViewController
        } else {
            print("Could not find corresponding segue")
        }
    }
    
    func showDiscoverIfUserLoggedIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                if let storyboard = self.storyboard {
                    let destinationViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(destinationViewController, animated: true, completion: nil)
                }
            } else { return }
        }
    }
    
    func setUpUserInterface() {
        passwordTextField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 20
        registerButton.clipsToBounds = true
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor(red: 255/255, green: 126/255, blue: 121/255, alpha: 1).cgColor
    }
}
