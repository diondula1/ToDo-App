//
//  Register.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/13/21.
//

import UIKit
import SimpleNetworkCall

class RegisterViewController: UIViewController {
    var registerView = RegisterView()
    
    override func viewDidLoad() {
        setView()
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(registerView)
        registerView.frame = view.bounds
    }
    
    @objc func registerAction(){
        if let name = registerView.nameTextField.text,
           let surname = registerView.surnameTextField.text,
           let username = registerView.usernameTextField.text,
           let password = registerView.passwordTextField.text{
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
        
        registerView.clearTextField()
    }
    
}

