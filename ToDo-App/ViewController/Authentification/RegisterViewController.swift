//
//  Register.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/13/21.
//

import UIKit
import SimpleNetworkCall

class RegisterService {
    func register(with requestRegister: RequestRegister) async throws -> ReturnObject<User> {
        let url = URL(string: "http://127.0.0.1:3000/api/auth/register")!
        var request = URLRequest(url: url)
        request.getRequest(body: requestRegister, httpMethod: "POST")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let user = try JSONDecoder().decode(ReturnObject<User>.self, from: data)
        
        return user
    }
}

class RegisterViewModel {
    let service: RegisterService
    
    internal init(service: RegisterService) {
        self.service = service
    }
}

class RegisterViewController: UIViewController {

    
    var registerView = RegisterView()
    let registerViewModel: RegisterViewModel
    
    internal init(registerViewModel: RegisterViewModel) {
        self.registerViewModel = registerViewModel
        super.init(nibName: nil, bundle: nil)
    }
  
    override func viewDidLoad() {
        setView()
        
        registerView.registerClicked = {
            self.registerAction()
        }
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(registerView)
        registerView.frame = view.bounds
    }
    
    func registerAction() {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

