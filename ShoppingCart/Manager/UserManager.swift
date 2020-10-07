//
//  UserManager.swift
//  ShoppingCart
//
//  Created by Mac on 02/10/2020.
//

import Foundation
import Alamofire
import JWTDecode

import UIKit

protocol UserManagerLoginDelegate {
    func showLoginErrors(email: String?, password: String?, emailErrorIsHidden: Bool, passErrorIsHidden: Bool)
}

protocol UserManagerSignUpDelegate {
    func showSignupErrors(email: String?, password: String? , confirmPass: String?, emailErrorIsHidden: Bool, passErrorIsHidden: Bool, cnfrmPassIsHidden: Bool)
}

protocol ChangeViewDelegate {
    func showView(storyboardID: String)
}

protocol ShowAlertViewDelegate {
    func showAlert(title: String, message: String)
}

struct UserManager {
    
    
    
    var loginDelegate: UserManagerLoginDelegate?
    var signupDelegate: UserManagerSignUpDelegate?
    var changeViewDelegate: ChangeViewDelegate?
    var showAlertViewDelegate: ShowAlertViewDelegate?
    
    
    
    
    func login(email:String, password: String) {
        if email.isEmpty  && password.isEmpty{
            
            self.loginDelegate?.showLoginErrors(email: "Please enter your email.", password: "Please enter your password.", emailErrorIsHidden: false, passErrorIsHidden: false)
            
        }
        else if email.isEmpty  {
            
            self.loginDelegate?.showLoginErrors(email: "Please enter your email.", password: nil , emailErrorIsHidden: false, passErrorIsHidden: true)
        }
        else if password.isEmpty  {
            
            self.loginDelegate?.showLoginErrors(email: nil, password: "Please enter your password.", emailErrorIsHidden: true, passErrorIsHidden: false)
        }
        else if  email.contains("@") == false || email.contains(".com") == false   {
            
            self.loginDelegate?.showLoginErrors(email: "Please enter valid email.", password: nil, emailErrorIsHidden: false, passErrorIsHidden: true)
            
        }
        else {
            let parameters = [
                "email": email,
                "password": password
            ]
            
            APICaller.shared.performAPICall(url: loginURL,expectedReturnType: UserSignIn.self, parameters: parameters, method: .post) { (result) in
                switch result {
                case .success(let user):
                    do {
                        let jwt = try decode(jwt: user.token)
                        
                        let currentUser = [
                            "userId": jwt.body["_id"],
                            "userEmail": jwt.body["email"],
                            "isTokenExpired": jwt.expired
                        ]
                        
                        UserDefaults.standard.setValue(currentUser, forKey: userSession)
                        
                        self.changeViewDelegate?.showView(storyboardID: "HomeViewController")
                        
                    }catch let error {
                        fatalError(error.localizedDescription)
                    }
                case .failure(.notFound):
                    self.loginDelegate?.showLoginErrors(email: "Email does not exist.", password: nil, emailErrorIsHidden: false, passErrorIsHidden: true)
                case .failure(.badURL):
                    print("bad url")
                case .failure(.internalServerError):
                    self.showAlertViewDelegate?.showAlert(title: "Internal Server Error!", message: "Oops! Something went wrong.")
                case .failure(.emailAlreadyExist):
                    print("Email already exist.")
                }
            }
            
        }
    }
    
    
    // Signup
    
    func signup(email: String, password: String, cnfrmPass: String)  {
        if email.isEmpty  && password.isEmpty  && cnfrmPass.isEmpty  {
            self.signupDelegate?.showSignupErrors(email: "Email is required.", password: "Password is required.", confirmPass: nil, emailErrorIsHidden: false, passErrorIsHidden: false, cnfrmPassIsHidden: true)
        }
        else if email.isEmpty  {
            self.signupDelegate?.showSignupErrors(email: "Email is required.", password: nil, confirmPass: nil, emailErrorIsHidden: false, passErrorIsHidden: true, cnfrmPassIsHidden: true)
        }
        else if password.isEmpty  {
            self.signupDelegate?.showSignupErrors(email: nil, password: "Password is required.", confirmPass: nil, emailErrorIsHidden: true, passErrorIsHidden: false, cnfrmPassIsHidden: true)
        }
        else if cnfrmPass.isEmpty  {
            self.signupDelegate?.showSignupErrors(email: nil, password: nil, confirmPass: "Please re-enter your password.", emailErrorIsHidden: true, passErrorIsHidden: true, cnfrmPassIsHidden: false)
        }
        else if email.contains("@") == false || email.contains(".com") == false {
            self.signupDelegate?.showSignupErrors(email: "Please enter valid email.", password: nil , confirmPass: nil, emailErrorIsHidden: false, passErrorIsHidden: true, cnfrmPassIsHidden: true)
        }
        else if cnfrmPass != password {
            self.signupDelegate?.showSignupErrors(email: nil, password: nil, confirmPass: "Password does not match.", emailErrorIsHidden: true, passErrorIsHidden: true, cnfrmPassIsHidden: false)
        }
        else {
            
            let parameters = [
                "email": email,
                "password": password
            ]
            
            APICaller.shared.performAPICall(url: signupURL, expectedReturnType: UserSignUp.self, parameters: parameters, method: .post) { (result) in
                
                switch result {
                case .success(let user):
                    print(user.userDetails)
                    self.changeViewDelegate?.showView(storyboardID: "HomeViewController")
                    
                case .failure(.internalServerError):
                    self.showAlertViewDelegate?.showAlert(title: "Internal Server Error!", message: "Oops! Something went wrong.")
                    
                case .failure(.emailAlreadyExist):
                    self.signupDelegate?.showSignupErrors(email: "Email already exist. Please change your email.", password: nil, confirmPass: nil, emailErrorIsHidden: false, passErrorIsHidden: true, cnfrmPassIsHidden: true)
                    
                case .failure(.notFound):
                    print("User not found")
                    
                case .failure(.badURL):
                    self.showAlertViewDelegate?.showAlert(title: "No Internet", message: "Internet connection timed out.")
                
                }
                
                
        }
    }
}
}
