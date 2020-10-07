//
//  User.swift
//  ShoppingCart
//
//  Created by Mac on 03/10/2020.
//

import Foundation


struct UserSignUp: Codable {
    var userDetails: userDetails
}

struct userDetails: Codable {
    var _id: String
    var email: String
    var password: String
    var __v: Int
}

struct UserSignIn: Codable {
    var message: String
    var token: String
}
