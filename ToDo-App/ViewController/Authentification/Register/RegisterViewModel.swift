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
    let service: RegisterServiceProtocol
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var state: State<User> = .none
    
    internal init(service: RegisterServiceProtocol) {
        self.service = service
    }
    
    func registerTouch() {
        Task {
            let requestRegister = RequestRegister(Name: name, Surname: surname, Username: username, Password: password)
            await fetchRegister(with: requestRegister)
        }
    }
    
    func fetchRegister(with requestRegister: RequestRegister) async {
        state = .loading
        do {
            let user = try await service.register(with: requestRegister)
            state = user.success
            ? .success(object: user.data!)
            : .error(error: .notAuthorized)
        } catch {
            state = .error(error: .notAuthorized)
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
