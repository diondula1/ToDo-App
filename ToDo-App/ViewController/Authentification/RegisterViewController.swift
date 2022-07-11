//
//  Register.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/13/21.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    var anyCancellable = Set<AnyCancellable>()
    var registerView = RegisterView()
    let viewModel: RegisterViewModel
    
    var registerCompleted: ((User) -> ())?
    
    internal init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setBinders()
        setView()
    }
    
    func setBinders() {
        viewModel.bind(registerView.nameTextField, to: \.name)
        viewModel.bind(registerView.surnameTextField, to: \.surname)
        viewModel.bind(registerView.usernameTextField, to: \.username)
        viewModel.bind(registerView.passwordTextField, to: \.password)
        
        viewModel
            .$state
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                switch result {
                case .loading:
                    print("Loading")
                case .error(error: let error):
                    self?.showAlert(alertText: "Incorrect!", alertMessage: error.localizedDescription)
                case .success(object: let user):
                    self?.registerCompleted?(user)
                case .none: break
                }
            }.store(in: &anyCancellable)
        
        registerView.registerClicked = {
            self.viewModel.registerAction()
        }
    }
    
    func setView() {
        view.backgroundColor = .white
        view.addSubview(registerView)
        registerView.frame = view.bounds
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

