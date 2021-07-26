//
//  Register.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/13/21.
//

import UIKit
import SimpleNetworkCall

class RegisterViewController: UIViewController {
    
    //
    var nameTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        return textField
    }()
    
    var surnameTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "SurName"
        return textField
    }()
    
    var usernameTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username"
        return textField
    }()
    
    var passwordTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var registerButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        setupView()
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    }
    
    @objc func registerAction(){
        if let name = nameTextField.text , let surname = surnameTextField.text,let username = usernameTextField.text ,  let password = passwordTextField.text{
            if name.isEmpty || surname.isEmpty || username.isEmpty || password.isEmpty {
                self.showAlert(alertText: "Emty TextField", alertMessage: "Please Fill TextField!!")
                return
            }
            let requestRegister =  RequestRegister(Name: name, Surname: surname, Username: username, Password: password)
            Network.shared.post(body: requestRegister, urlString: "".getRegisterServerURL()) { (results: Result<ReturnObject<User>,Error>) in
                switch(results){
                case .failure(let err):
                    print(err)
                    
                case .success(let data):
                    if let data = data.data{
                        UserDefaultsData.token = data.token
                        self.moveToMainView()
                    }else{
                        self.showAlert(alertText: "Incorrect!", alertMessage: data.message)
                    }
                }
            }
        }
    }
    
    func moveToMainView() {
        let navigationController = MenuBarViewController()
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        self.present(navigationController, animated: true, completion: nil)
        
        clearTextField()
    }
    
    //MARK: Methods
    func clearTextField() {
        nameTextField.text = ""
        surnameTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    
}


extension RegisterViewController : ViewCode {
    func buildViewHierarchy() {
        self.view.addSubview(nameTextField)
        self.view.addSubview(surnameTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(registerButton)
    }
    
    func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            surnameTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 20),
            surnameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            usernameTextField.topAnchor.constraint(equalTo: self.surnameTextField.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 40),
            registerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
    
    
}
