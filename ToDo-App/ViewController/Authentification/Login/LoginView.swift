//
//  LoginView.swift
//  ToDo-App
//
//  Created by Dion Dula on 9.7.22.
//

import UIKit

class LoginView: UIView {
    //MARK: UI
    var userNameTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username or Email"
        return textField
    }()
    
    var passwordTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        return textField
    }()
    
    var loginButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .green
        
        return button
    }()
    
    var registerButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    var loginClicked: (() -> ())?
    var registerClicked: (() -> ())?
    
    @objc
    func loginAction() {
        loginClicked?()
    }
    
    @objc
    func registerAction(){
        registerClicked?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SetupView
extension LoginView: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(userNameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userNameTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,constant: -20),
            userNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -100),
            
            passwordTextField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,constant: 20),
            
            loginButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20),
            
            registerButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor,constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,constant: -20),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 20),
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    }
    
    //MARK: Methods
    func clearTextField() {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}
