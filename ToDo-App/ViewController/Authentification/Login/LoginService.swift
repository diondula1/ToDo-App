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
        
        var request = getRequest(body: requestLogin, url: url)
        request.httpMethod = "POST"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let userResult = try JSONDecoder().decode(ReturnObject<User>.self, from: data)
        return userResult
    }
    
    private func getRequest<T: Encodable>(body: T?,url: URL,headerParameters: [String : String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        for headerParameter in headerParameters {
            request.addValue(headerParameter.value, forHTTPHeaderField: headerParameter.key)
        }
        
        if let body = body{
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch  {
                print(error)
            }
        }
        
        return request
    }
}
