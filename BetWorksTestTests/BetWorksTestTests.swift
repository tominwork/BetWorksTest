//
//  BetWorksTestTests.swift
//  BetWorksTestTests
//
//  Created by Thomas Varghese on 2020-12-24.
//

import XCTest
@testable import BetWorksTest

let userName = "user123"

class BetWorksTestTests: XCTestCase {

    var networkClient: NetworkClient!
    var mockSession: MockURLSession!
    var mockData: Data!
    var loginViewModel: LoginViewModel!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkClient = nil
        mockSession = nil
        loginViewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUserLogin_validCredentials() {
        loginViewModel = LoginViewModel()
        XCTAssertTrue(loginViewModel.login(withUserName: userName, andPassword: "pwd123"))
    }
    
    func testUserLogin_invalidCredentials() {
        loginViewModel = LoginViewModel()
        XCTAssertFalse(loginViewModel.login(withUserName: "user123", andPassword: "pwd"))
        XCTAssertFalse(loginViewModel.login(withUserName: "user", andPassword: "pwd"))
        XCTAssertFalse(loginViewModel.login(withUserName: "123", andPassword: "pwd"))
        XCTAssertFalse(loginViewModel.login(withUserName: "123", andPassword: "645"))
        XCTAssertFalse(loginViewModel.login(withUserName: "user", andPassword: "645"))
    }
    
    func testNetworkClient_successResult() {
        mockSession = createMockSession(fromURL: loginUrl, andStatusCode: successCode, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        
        networkClient.login(url: URL(string: loginUrl)!, userName: userName, password: "pwd123") { user, errorMessage in
            XCTAssertNotNil(user)
            XCTAssertTrue(user?.isSuccessful == true)
            XCTAssertNil(errorMessage)
            XCTAssertTrue(user?.userName == "user123")
        }
    }

    func testNetworkClient_404Result() {
        mockSession = createMockSession(fromURL: loginUrl, andStatusCode: 404, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        
        networkClient.login(url: URL(string: loginUrl)!, userName: userName, password: "pwd123") { user, errorMessage in
            XCTAssertNotNil(errorMessage)
            XCTAssertNotNil(user)
            XCTAssertTrue(user?.isSuccessful == false)
            XCTAssertTrue(errorMessage == "Wrong Url or Server Error.")
        }
    }

    func testNetworkClient_AnotherStatusCode() {
        mockSession = createMockSession(fromURL: loginUrl, andStatusCode: 401, andError: nil)
        networkClient = NetworkClient(withSession: mockSession)
        
        networkClient.login(url: URL(string: loginUrl)!, userName: userName, password: "pwd123") { user, errorMessage in
            XCTAssertNotNil(errorMessage)
            XCTAssertNil(user)
            XCTAssertTrue(errorMessage == "statusCode: 401")
        }
    }

    private func createMockSession(fromURL url: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {
        let data = Data(userName.utf8)
        let response = HTTPURLResponse(url: URL(string: url)!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
