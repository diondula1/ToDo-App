//
//  LoginService.swift
//  ToDo-App
//
//  Created by Dion Dula on 9.7.22.
//

import Foundation

class LoginService {
    func login(requestLogin: RequestLogin) async throws -> ReturnObject<User> {
        let url = URL(string: "http://127.0.0.1:3000/api/auth/login")!
        var request = URLRequest(url: url)
        request.getRequest(body: requestLogin, httpMethod: "POST")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let userResult = try JSONDecoder().decode(ReturnObject<User>.self, from: data)
        return userResult
    }
}
