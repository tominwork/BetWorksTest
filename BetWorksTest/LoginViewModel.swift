//
//  LoginViewModel.swift
//  BetWorksTest
//
//  Created by Thomas Varghese on 2020-12-24.
//

import Foundation
import UIKit

let loginUrl = "http://fireflysoftware.ca/login"
let successCode = 200


class LoginViewModel {
    
    var networkClient: NetworkClient!
    var mockSession: MockURLSession!
    var userName: String!
    
    func login(withUserName userName: String, andPassword: String) -> Bool {
        var result = false
        
        if !isValidCredential(credential: userName) || !isValidCredential(credential: andPassword) {
            return result
        }
        else {
            self.userName = userName
            mockSession = createMockSession(fromURL: loginUrl, andStatusCode: successCode, andError: nil)
            let networkClient = NetworkClient(withSession: mockSession)
            
            networkClient.login(url: URL(string: loginUrl)!, userName: userName, password: andPassword) { user, errorMessage in
                if let user = user, user.isSuccessful {
                    User.shared.userName = user.userName
                    result = true
                }
            }
        }
        return result
    }
    
    private func isValidCredential(credential: String) -> Bool {
        let trimmedString = credential.trimmingCharacters(in: CharacterSet.whitespaces)
        let credentialRegex = "^(?=.*\\d)(?=.*[a-zA-Z]).{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", credentialRegex).evaluate(with: trimmedString)
    }
    
    func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "BetWorksTest", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))        
        return alert
    }
    
    private func createMockSession(fromURL url: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {
        let data = Data(userName.utf8)
        let response = HTTPURLResponse(url: URL(string: url)!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
