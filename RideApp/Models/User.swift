//
//  User.swift
//  RideApp
//
//  Created by Masud Onikeku on 04/06/2023.
//

import Foundation

struct User : Codable {
    
    let firstName : String?
    let lastName: String?
    let phone : String?
    let email : String?
}

struct CheckResponse : Codable {
    
    let users : [User]?
    
}
