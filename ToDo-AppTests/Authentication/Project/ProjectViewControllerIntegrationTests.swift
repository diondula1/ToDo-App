//
//  ProjectViewControllerTests.swift
//  ToDo-AppTests
//
//  Created by Dion Dula on 8/2/22.
//

import Foundation
import XCTest
@testable import ToDo_App

class ProjectViewControllerIntegrationTests: XCTestCase {
    func test_viewDidload_init() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
    }
    
    func test_tableView_init() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.delegate, "delegate")
        XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
    }
    
    private func makeSUT() -> ProjectController {
        ProjectController()
    }
}
