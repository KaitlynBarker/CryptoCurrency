//
//  LoginViewController.swift
//  CryptoCurrency
//
//  Created by José Fernando Márquez Cruz on 15/06/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var result = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.setBottomBorder()
        
        self.emailTextField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "userIcon.png")
        imageView.image = image
        self.emailTextField.leftView = imageView
 
        
        self.passwordTextField.setBottomBorder()
        
        self.passwordTextField.leftViewMode = UITextFieldViewMode.always
        let imageViewPass = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imagePass = UIImage(named: "passwordIcon.png")
        imageViewPass.image = imagePass
        self.passwordTextField.leftView = imageViewPass
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            checkForUserNameAndPasswordMatch(email: self.emailTextField.text!, password: self.passwordTextField.text!)
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkForUserNameAndPasswordMatch( email: String, password : String){
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserLogin")
        
        let predicate = NSPredicate(format: "email = %@", email)
        
        fetchrequest.predicate = predicate
        do
        {
            result = try context.fetch(fetchrequest) as NSArray
            
            if result.count>0{
                let objectEntity = result.firstObject as! UserLogin
                
                if objectEntity.email == email && objectEntity.password == password {
                    //performSegue(withIdentifier: "loginSegue", sender: self)
                    /*
                    let alertController = UIAlertController(title: "Success", message: "Login succesful", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    print("Login Succesfully")
                     
                    */
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Please enter a valid email and password.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }else{
                let alertController = UIAlertController(title: "Error", message: "There is no registered users", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            
            }
        }catch {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
        
    }

    
}

