//
//  ViewController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/8/21.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    var anyCancellable = Set<AnyCancellable>()
    let viewModel: LoginViewModel
    let loginView = LoginView()
    
    var loginCompleted: ((User) -> ())?
    var registerClicked: (() -> ())?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBindings()
        setView()
    }
    
    func setView() {
        view.backgroundColor = .white
        loginView.frame = view.bounds
        view.addSubview(loginView)
    }
    
    func setBindings() {
        viewModel.bind(loginView.userNameTextField, to: \.username)
        viewModel.bind(loginView.passwordTextField, to: \.password)
        
        viewModel
            .$state
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                switch result {
                case .loading:
                    print("Loading")
                case .error:
                    self?.showAlert(alertText: "Something went wrong !!", alertMessage: "Server Error!!.")
                case let .success(object):
                    self?.loginCompleted?(object)
                    self?.loginView.clearTextField()
                case .none: break
                }
            }
            .store(in: &anyCancellable)
        
        loginView.loginClicked = {
            self.viewModel.loginTouch()
        }
        
        loginView.registerClicked = {
            self.registerClicked?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


