//
//  LoginViewController.swift
//  CryptoCurrency
//
//  Created by José Fernando Márquez Cruz on 15/06/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setBottomBorder()
        
        emailTextField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "userIcon.png")
        imageView.image = image
        emailTextField.leftView = imageView
 
        
        passwordTextField.setBottomBorder()
        
        passwordTextField.leftViewMode = UITextFieldViewMode.always
        let imageViewPass = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imagePass = UIImage(named: "passwordIcon.png")
        imageViewPass.image = imagePass
        passwordTextField.leftView = imageViewPass
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

