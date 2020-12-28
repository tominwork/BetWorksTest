//
//  User.swift
//  BetWorksTest
//
//  Created by Thomas Varghese on 2020-12-27.
//

import Foundation

class User {
    
    static let shared = User()
    var userName: String?
    
    private init(){}

}
