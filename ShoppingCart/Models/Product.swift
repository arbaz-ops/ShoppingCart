//
//  Product.swift
//  ShoppingCart
//
//  Created by Mac on 05/10/2020.
//

import Foundation

struct Products: Codable {
    var products: [Product]
}

struct Product: Codable {
    var _id: String
    var name: String
    var brand: String
    var price: Int
    var description: String
    var size: [String]
    var productImage: String
    
    var request: request
}

struct request: Codable {
    var method: String
    var url: String
}


struct CreatedProduct: Codable {
    var productDetails: Product
    var request: request
}

struct ProductCreated {
    var size: [String]
    var _id: String
    var name: String
    var price: Int
    var brand: String
    var description: String
    var productImage: String
    var __v: Int
}

