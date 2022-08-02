//
//  LoginViewModelTests.swift
//  ToDo-AppTests
//
//  Created by Dula Dion on 19/07/22.
//

import XCTest
import Combine

@testable import ToDo_App

typealias UserState = State<User>

class LoginViewModelTests: XCTestCase {

    func test_init() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_fetchData_whenLoginIsTouchSuccess() async {
        let user = makeUser()
        let sut = makeSUT(user: user)
        let spy = ValuSpy<UserState>(sut.$state.eraseToAnyPublisher())
        
        XCTAssertEqual(spy.values, [.none])
        await sut.fetchResults(with: makeRequestLogin())
        XCTAssertEqual(spy.values, [.none, .loading, .success(object: user)])
    }
    
    
    func test_fetchData_whenLoginIsTouchError() async {
        let sut = makeSUT(isSuccess: false, user: makeUser())
        let spy = ValuSpy<UserState>(sut.$state.eraseToAnyPublisher())
        
        XCTAssertEqual(spy.values, [.none])
        await sut.fetchResults(with: makeRequestLogin())
        XCTAssertEqual(spy.values, [.none, .loading, .error(error: .notAuthorized)])
    }
    
    //MARK: Helpers
    func makeSUT(isSuccess: Bool = true,
                 user: User = User(id: "Dion", username: "Dion", token: "123")
    ) -> LoginViewModel {
        let service = LoginServiceMock(isSuccess: isSuccess, user: user)
       
        return LoginViewModel(service: service)
    }
    
    func makeRequestLogin() -> RequestLogin {
        RequestLogin(Username: "Dion", Password: "Dula")
    }
    
    func makeUser() -> User {
        User(id: "Dion", username: "Dion", token: "123")
    }
}
