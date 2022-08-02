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
        user.token.isEmpty ? callAuthentication() : callMain()
    }
    
    func callAuthentication() {
        let authentication = AuthenticationRouter(navigation: navigation)
        authentication.start()
        
        authentication.loginCompleted = { user in
            UserDefaultsData.token = user.token
            UserDefaultsData.id = user.id
            self.callMain()
        }
    }
    
    func callMain() {
        let mainRouter = MainRouter(navigation: navigation)
        mainRouter.start()
    }
}

class MainRouter {
    var navigation: UINavigationController
    
    internal init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    
    func start() {
        let viewController = MenuBarViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        navigation.present(viewController, animated: true)
    }
}

class AuthenticationRouter {
    var navigation: UINavigationController
    var loginCompleted: ((User) -> ())?
    
    internal init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let service = LoginServiceMock()
        let viewModel = LoginViewModel(service: service)
        let viewController = LoginViewController(viewModel: viewModel)
        navigation.pushViewController(viewController, animated: true)
        
        viewController.loginCompleted = { user in
            self.loginCompleted?(user)
        }
        
        viewController.registerClicked = {
            self.moveToRegistrationPage()
        }
    }
    
    func moveToRegistrationPage() {
        let service = RegisterService()
        let viewModel = RegisterViewModel(service: service)
        let newViewController = RegisterViewController(viewModel: viewModel)
         
        newViewController.registerCompleted = { user in
            self.loginCompleted?(user)
        }
        
        newViewController.modalPresentationStyle = .fullScreen
        navigation.pushViewController(newViewController, animated: true)
    }
}
