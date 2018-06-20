//
//  SignUpViewController.swift
//  CryptoCurrency
//
//  Created by José Fernando Márquez Cruz on 19/06/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        confirmPassTextField.setBottomBorder()
        nameTextField.setBottomBorder()
        lastNameTextField.setBottomBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" || self.confirmPassTextField.text == "" ||
            self.nameTextField.text == "" || self.lastNameTextField.text == ""{
            
            let alertController = UIAlertController(title: "Error", message: "Please complete all the fields.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            
            if self.passwordTextField.text == self.confirmPassTextField.text {
                
                let app = UIApplication.shared.delegate as! AppDelegate
                
                let context = app.persistentContainer.viewContext
                
                let user = NSEntityDescription.insertNewObject(forEntityName: "UserLogin", into: context)
                
                
                user.setValue(self.emailTextField.text, forKey: "email")
                user.setValue(self.passwordTextField.text, forKey: "password")
                user.setValue(self.lastNameTextField.text, forKey: "lastName")
                user.setValue(self.nameTextField.text, forKey: "name")

                
                do{
                    try context.save()
                    print("Registered  Sucessfully")
                    let alertController = UIAlertController(title: "Succesful", message: "User registered succesful, go to Login screen.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }catch
                {
                    let Fetcherror = error as NSError
                    print("error", Fetcherror.localizedDescription)
                }
                
            }else{
                let alertController = UIAlertController(title: "Error", message: "The passwords you entered must match.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
  /*
    @IBAction func register(_ sender: Any)
    {
        if txt_user.text == "" || txt_mailid.text == "" || txt_pwd.text == "" || txt_cpwd.text == "" || txt_phone.text == ""
        {
            let alert = UIAlertController(title: "Information", message: "Its Mandatort to enter all the fields", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if (txt_pwd.text != txt_cpwd.text)
        {
            let alert = UIAlertController(title: "Information", message: "Password does not match", preferredStyle: .alert
            )
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else
        {
            let app = UIApplication.shared.delegate as! AppDelegate
            
            let context = app.persistentContainer.viewContext
            
            let new_user = NSEntityDescription.insertNewObject(forEntityName: "LoginDetails", into: context)
            
            new_user.setValue(txt_user.text, forKey: "username")
            new_user.setValue(txt_mailid.text, forKey: "mailid")
            new_user.setValue(txt_pwd.text, forKey: "password")
            new_user.setValue(txt_phone.text, forKey: "phone")
            
            do
            {
                try context.save()
                print("Registered  Sucessfully")
            }
            catch
            {
                let Fetcherror = error as NSError
                print("error", Fetcherror.localizedDescription)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }

    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
