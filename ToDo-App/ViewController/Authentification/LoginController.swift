//
//  ViewController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/8/21.
//

import UIKit
import SimpleNetworkCall

class LoginController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaultsData.token != ""{
            moveToMainView()
        }
        
    }
    
    //MARK: Actions
    @objc
    func loginAction() {
        
        if let userName = userNameTextField.text , let password = passwordTextField.text{
            
            if userName.isEmpty || password.isEmpty {
                self.showAlert(alertText: "Emty TextField", alertMessage: "Please Fill TextField!!")
                return
            }
            let requestLogin = RequestLogin(Username: userName, Password: password)
            Network.shared.post(body: requestLogin, urlString: "".getLoginServerURL()) { (results: Result<ReturnObject<User>,Error>) in
                switch(results){
                case .failure(let err):
                    print(err)
                    
                case .success(let data):
                    if data.success {
                        if let data = data.data {
                            UserDefaultsData.token = data.token
                            UserDefaultsData.id = data.id
                            self.moveToMainView()
                        }else{
                            self.showAlert(alertText: "Something went wrong !!", alertMessage: "Server Error!!.")
                        }
                    }else{
                        self.showAlert(alertText: "Server Error!", alertMessage: data.message)
                    }
                }
            }
        }
    }
    
    @objc
    func registerAction(){
        let newViewController = RegisterViewController()
        newViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func moveToMainView(){
        let navigationController = MenuBarViewController()
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        clearTextField()
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    func clearTextField(){
        //TODO: Clear TextField
    }
}

extension LoginController : ViewCode {
    
    func buildViewHierarchy() {
        self.view.addSubview(userNameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            userNameTextField.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor,constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor,constant: -20),
            userNameTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -100),
            
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor,constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor,constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,constant: 20),
            
            loginButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor,constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor,constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20),
            
            registerButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor,constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor,constant: -20),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 20),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
    
}
