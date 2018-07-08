//
//  TwoFactorAuthViewController.swift
//  CryptoCurrency
//
//  Created by José Fernando Márquez Cruz on 25/06/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit
import OneTimePassword

class TwoFactorAuthViewController: UIViewController {
    
    @IBOutlet weak var googleAuthTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleAuthTextField.setBottomBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitTwoFactorPressed(_ sender: Any) {
        
        //let url = URL(string: "otpauth://totp/CryptoCurrency:nanditovelvet@gmail.com?secret=JBSWY3DPEHPK3PXP&issuer=CryptoCurrency")
        let url = URL(string: "otpauth://totp/ACME%20Co:john@example.com?secret=HXDMVJECJJWSRB3HWIZR4IFUGFTMXBOZ&issuer=ACME%20Co&algorithm=SHA1&digits=6&period=30")
        if let token = Token(url: url!) {
            print("\(token.currentPassword ?? "no value")")
            if(token.currentPassword == googleAuthTextField.text){
                let alertController = UIAlertController(title: "Success", message: "Complete login", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Error", message: "Invalid token", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        } else {
          
            print("Invalid Token")
            
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
