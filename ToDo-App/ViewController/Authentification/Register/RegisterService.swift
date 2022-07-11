//
//  RegisterService.swift
//  ToDo-App
//
//  Created by Dion Dula on 10.7.22.
//

import Foundation

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
