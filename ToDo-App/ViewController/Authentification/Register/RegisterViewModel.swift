//
//  RegisterViewModel.swift
//  ToDo-App
//
//  Created by Dion Dula on 10.7.22.
//

import UIKit
import Combine

class RegisterViewModel {
    var anyCancellable = Set<AnyCancellable>()
    let service: RegisterService
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var state: State<User> = .none
    
    internal init(service: RegisterService) {
        self.service = service
    }
    
    func registerAction() {
        state = .loading
        Task {
            let requestRegister = RequestRegister(Name: name, Surname: surname, Username: username, Password: password)
            
            do {
                let user = try await service.register(with: requestRegister)
                state = user.success ? .success(object: user.data!) : .error(error: NSError(domain: user.message, code: user.status))
            } catch {
                state = .error(error: error)
            }
        }
    }
}

extension RegisterViewModel {
    func bind(_ textField: UITextField, to property: ReferenceWritableKeyPath<RegisterViewModel, String>) {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .sink(receiveValue: { result in
                if let textField = result.object as? UITextField,
                   let text = textField.text {
                    self[keyPath: property] = text
                }
            })
            .store(in: &anyCancellable)
    }
}
