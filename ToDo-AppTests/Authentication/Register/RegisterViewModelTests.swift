//
//  RegisterViewModelTests.swift
//  ToDo-AppTests
//
//  Created by Dula Dion on 19/07/22.
//

import XCTest
@testable import ToDo_App

class RegisterViewModelTests: XCTestCase {
    func test_init() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_fetchData_whenRegisterIsSuccess() async {
        let user = User(id: "Dion", username: "Dion", token: "123")
        let sut = makeSUT(user: user)
        let spy = ValuSpy<UserState>(sut.$state.eraseToAnyPublisher())
        
        XCTAssertEqual(spy.values, [.none])
        await sut.fetchRegister(with: makeRequestRegister())
        XCTAssertEqual(spy.values, [.none, .loading, .success(object: user)])
    }
    
    func test_fetchData_whenRegisterFailed() async {
        let sut = makeSUT(isSuccess: false)
        let spy = ValuSpy<UserState>(sut.$state.eraseToAnyPublisher())
        
        XCTAssertEqual(spy.values, [.none])
        await sut.fetchRegister(with: makeRequestRegister())
        XCTAssertEqual(spy.values, [.none, .loading, .error(error: .notAuthorized)])
    }
    
    //MARK: Helpers
    private func makeRequestRegister() -> RequestRegister {
        RequestRegister(Name: "", Surname: "", Username: "", Password: "")
    }
    
    private func makeSUT(isSuccess: Bool = true, user: User = User(id: "Dion", username: "Dion", token: "123")) -> RegisterViewModel {
        let service = RegisterServiceMock(isSuccess: isSuccess, user: user)
        return RegisterViewModel(service: service)
    }
}
