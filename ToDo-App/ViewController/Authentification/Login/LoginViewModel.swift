//
//  LoginViewModel.swift
//  ToDo-App
//
//  Created by Dion Dula on 9.7.22.
//

import UIKit
import Combine

enum State<T>: Equatable where T: Equatable {
    static func == (lhs: State<T>, rhs: State<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.success(object: lhsObject),.success(object: rhsObject)):
            return lhsObject == rhsObject
        case (.loading, .loading):
            return true
        case (.error(error: let lhsError), .error(error: let rhsError)):
            return lhsError == rhsError
        case (.none, .none):
            return true
        default:
            return false
        }
    }
    
    case loading
    case error(error: LoginError)
    case success(object: T)
    case none
}

enum LoginError: Error, Equatable {
    case notAuthorized
}

class LoginViewModel {
    let service: LoginServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var state: State<User> = .none
    
    init(service: LoginServiceProtocol) {
        self.service = service
    }
    
    func loginTouch() {
        Task {
            let requestLogin = RequestLogin(Username: username, Password: password)
            await fetchResults(with: requestLogin)
        }
    }
    
    func fetchResults(with requestLogin: RequestLogin) async {
        state = .loading
        
        do {
            let user = try await service.login(requestLogin: requestLogin)
            state = user.success ? .success(object: user.data!) : .error(error: LoginError.notAuthorized)
        } catch {
            state = .error(error: LoginError.notAuthorized)
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

