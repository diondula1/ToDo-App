//
//  LoginViewModel.swift
//  ToDo-App
//
//  Created by Dion Dula on 9.7.22.
//

import UIKit
import Combine

enum State<T> {
    case loading
    case error(error: Error)
    case success(object: T)
    case none
}

enum LoginError: Error {
    case notAuthorized
}

class LoginViewModel {
    
    
    let service: LoginService
    var cancellables = Set<AnyCancellable>()
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var state: State<User> = .none
    
    init(service: LoginService) {
        self.service = service
    }
    
    func loginTouch() {
        state = .loading
        
        Task {
            do {
                let requestLogin = RequestLogin(Username: username, Password: password)
                
                let user = try await LoginService().login(requestLogin: requestLogin)
                state = user.success ? .success(object: user.data!) : .error(error: LoginError.notAuthorized)
            } catch {
                state = .error(error: error)
            }
        }
    }
}

extension LoginViewModel {
    func bind(_ textField: UITextField, to property: ReferenceWritableKeyPath<LoginViewModel, String>) {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .sink(receiveValue: { result in
                if let textField = result.object as? UITextField,
                   let text = textField.text {
                    self[keyPath: property] = text
                }
            })
            .store(in: &cancellables)
    }
}

