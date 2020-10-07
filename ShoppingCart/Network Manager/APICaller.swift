//
//  APICaller.swift
//  ShoppingCart
//
//  Created by Mac on 03/10/2020.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case badURL, internalServerError, emailAlreadyExist, notFound
}

class APICaller {
    static let shared = APICaller()
    
    
    
    func performAPICall<T: Codable>(url: String,expectedReturnType: T.Type , parameters: Parameters?, method: HTTPMethod ,completionHandler: @escaping (Result<T,NetworkError>) -> () ) {
        
        
        AF.request(url, method: method, parameters: parameters).response { response in
            switch response.result {
            case .success:
                let httpCode = response.response?.statusCode
                switch httpCode {
                case 201:
                    
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data!)
                        completionHandler(.success(decodedData))
                        
                    }catch let error {
                        print(error.localizedDescription)
                    }
                    
                case 200:
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data!)
                        completionHandler(.success(decodedData))
                    }catch let error {
                        print(error.localizedDescription)
                    }
                case 404:
                    completionHandler(.failure(.notFound))
                case 500:
                    completionHandler(.failure(.internalServerError))
                case 409:
                    completionHandler(.failure(.emailAlreadyExist))
                default:
                    break
                }
            case .failure:
                
                completionHandler(.failure(.badURL))
            }
            
        }
    }
    
    func addProductWithUrl(parameters: Parameters)  {
        let headers = [ "Content-type": "multipart/form-data"]

        
        
    }

    }

