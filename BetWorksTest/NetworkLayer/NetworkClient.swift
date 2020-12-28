//
//  NetworkClient.swift
//  BetWorksTest
//
//  Created by Thomas Varghese on 2020-12-27.
//

import Foundation

struct LoginResponse: Codable {
    var userName: String
    var isSuccessful: Bool
}

struct NetworkClient {

    private var session: URLSessionProtocol

    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func login(url: URL, userName: String, password: String, completion: @escaping  (_ response: LoginResponse?, _ errorMessage: String?) -> Void) {
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }
            
            guard data != nil else {
                completion(nil, "No Data Received.")
                return
            }
            
            switch statusCode {
            case 200:
                let response = LoginResponse.init(userName: userName, isSuccessful: true)
                completion(response, nil)
            case 404:
                let response = LoginResponse.init(userName: userName, isSuccessful: false)
                completion(response, "Wrong Url or Server Error.")
            default:
                completion(nil, "statusCode: \(statusCode)")
            }
        }
        
        dataTask.resume()
    }
}
