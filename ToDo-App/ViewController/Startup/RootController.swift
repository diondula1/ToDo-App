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
            self.moveToMainViewController()
        }
        
        viewController.registerClicked = {
            self.moveToRegistrationPage()
        }
    }
    
    func moveToMainViewController() {
        let viewController = MenuBarViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        navigation.present(viewController, animated: true, completion: nil)
    }
    
    func moveToRegistrationPage() {
        let newViewController = RegisterViewController()
        newViewController.modalPresentationStyle = .fullScreen
        navigation.pushViewController(newViewController, animated: true)
    }
}
