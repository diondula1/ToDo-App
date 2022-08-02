//
//  ToDo_AppTests.swift
//  ToDo-AppTests
//
//  Created by Dula Dion on 19/07/22.
//

import XCTest
@testable import ToDo_App

class RootControllerTests: XCTestCase {

    func test_start_initView() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func test_start_openAuthenticationWhenTokenIsEmpty() {
        let sut = makeSUT()
        
        sut.start()
        
        XCTAssertNotNil(sut.navigation.topViewController as? LoginViewController)
    }
    
    func test_start_openMenuWhenTokenIsNotEmpty() {
        let navigation = NonAnimatedUINavigationController()
        let sut = makeSUT(navigation: navigation, token: "Test")
        sut.start()
        
        XCTAssertNotNil(navigation.viewControllerPresented as? MenuBarViewController)
    }
    
    private func makeSUT(navigation: UINavigationController = UINavigationController(),
                         token: String = "") -> RootController {
        RootController(navigation: navigation, user: .init(id: "", username: "", token: token))
    }
}

private class NonAnimatedUINavigationController: UINavigationController {
    var viewControllerPresented: UIViewController = UIViewController()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: false, completion: completion)
        self.viewControllerPresented = viewControllerToPresent
    }
}
