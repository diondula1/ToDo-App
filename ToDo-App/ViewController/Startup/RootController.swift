//
//  RootController.swift
//  ToDo-App
//
//  Created by Dion Dula on 9.7.22.
//

import Foundation
import UIKit

class RootController {
    var navigation: UINavigationController
    var user: User
    
    internal init(navigation: UINavigationController, user: User) {
        self.navigation = navigation
        self.user = user
    }
    
    func start() {
        user.token.isEmpty ? callAuthentication() : moveToMainViewController()
    }
    
    func callAuthentication() {
        let authentication = AuthenticationRouter(navigation: navigation)
        authentication.start()
        authentication.loginCompleted = {
            self.moveToMainViewController()
        }
    }
    
    func moveToMainViewController() {
        let viewController = MenuBarViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        navigation.present(viewController, animated: true)
    }
}

class AuthenticationRouter {
    var navigation: UINavigationController
    var loginCompleted: (() -> ())?
    
    internal init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let service = LoginService()
        let viewModel = LoginViewModel(service: service)
        let viewController = LoginController(viewModel: viewModel)
        navigation.pushViewController(viewController, animated: true)
        
        viewController.loginCompleted = { user in
            UserDefaultsData.token = user.token
            UserDefaultsData.id = user.id
            self.loginCompleted?()
        }
        
        viewController.registerClicked = {
            self.moveToRegistrationPage()
        }
    }
    
    func moveToRegistrationPage() {
        let service = RegisterService()
        let viewModel = RegisterViewModel(service: service)
        let newViewController = RegisterViewController(registerViewModel: viewModel)
        newViewController.modalPresentationStyle = .fullScreen
        navigation.pushViewController(newViewController, animated: true)
    }
}
