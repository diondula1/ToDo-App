//
//  HttpRequest+Extension.swift
//  ToDo-App
//
//  Created by Dion Dula on 10.7.22.
//

import Foundation

extension URLRequest {
    mutating func getRequest<T: Encodable>(body: T, httpMethod: String = "GET", headerParameters: [String : String] = [:]) {
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.httpMethod = httpMethod
        
        for headerParameter in headerParameters {
            addValue(headerParameter.value, forHTTPHeaderField: headerParameter.key)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            httpBody = jsonData
        }catch {
            print("Error: \(error)")
        }
    }
}
