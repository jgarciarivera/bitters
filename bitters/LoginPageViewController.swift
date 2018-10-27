//
//  LoginPageViewController.swift
//  bitters
//
//  Created by Kristian Galvan on 10/25/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginPageViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if let error = error {
                print(error.localizedDescription)
                    print("Error signing in!")
            } else if Auth.auth().currentUser != nil {
                print("Successful sign in!")
                self.performSegue(withIdentifier: "loginToMain", sender: self)

            }
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "loginToMain" {
            let dvc = segue.destination as! UITabBarController
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
