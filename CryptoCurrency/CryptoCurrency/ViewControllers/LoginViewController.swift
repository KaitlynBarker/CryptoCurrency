//
//  LoginViewController.swift
//  CryptoCurrency
//
//  Created by José Fernando Márquez Cruz on 15/06/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    let emailTextField: UITextField = {
        let e = UITextField()
        e.placeholder = "Email"
        e.textColor = .white
        e.backgroundColor = .red
        return e
    }()
    
    let passwordTextField: UITextField = {
        let p = UITextField()
        p.placeholder = "Password"
        p.textColor = .white
        p.backgroundColor = .blue
        return p
    }()
    
    let loginButton: UIButton = {
        let l = UIButton(type: .system)
        l.setTitleColor(.white, for: .normal)
        l.setTitle("Login In", for: .normal)
        l.backgroundColor = .purple
        return l
    }()
    
    let haveAccountButton: UIButton = {
        let color = UIColor(red: 89/255, green: 156/255, blue: 120/255, alpha: 1)
        let font = UIFont.systemFont(ofSize: 16)
        let h = UIButton(type: .system)
        h.backgroundColor = .green
        let attibutedTitle = NSMutableAttributedString(string: "Don´t have an account", attributes: [NSAttributedStringKey.foregroundColor:  color, NSAttributedStringKey.font: font])
        h.setAttributedTitle(attibutedTitle, for: .normal)
        
        return h
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GREEN_THEME
        setupTextFieldComponents()
        setupLoginButton()
        setupHaveAccountButton()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    fileprivate func setupTextFieldComponents(){
        setupEmailField()
        setupPasswordField()
    }

    fileprivate func setupEmailField(){
        view.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        //emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16 ).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24 ).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24 ).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupPasswordField(){
        view.addSubview(passwordTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8 ).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: 0 ).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: 0 ).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    fileprivate func setupLoginButton(){
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8 ).isActive = true
        loginButton.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: 0 ).isActive = true
        loginButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: 0 ).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupHaveAccountButton(){
        view.addSubview(haveAccountButton)
        
        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        haveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8 ).isActive = true
        haveAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12 ).isActive = true
        haveAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12 ).isActive = true
        haveAccountButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
