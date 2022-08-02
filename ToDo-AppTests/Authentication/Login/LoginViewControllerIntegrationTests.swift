//
//  LoginViewControllerIntegrationTests.swift
//  ToDo-AppTests
//
//  Created by Dula Dion on 20/07/22.
//

import XCTest
import Combine

@testable import ToDo_App

class LoginViewControllerIntegrationTests: XCTestCase {
    
    func test_viewDidLoad_init() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut)
    }
    
    //MARK: Helpers
    func makeSUT(isSuccess: Bool = true,
                 user: User = User(id: "Dion", username: "Dion", token: "123")
    ) -> LoginViewController {
        let service = LoginServiceMock(isSuccess: isSuccess, user: user)
        let viewModel = LoginViewModel(service: service)
        return LoginViewController(viewModel: viewModel)
    }
}
