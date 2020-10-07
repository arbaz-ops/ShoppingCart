//
//  ProductManager.swift
//  ShoppingCart
//
//  Created by Mac on 05/10/2020.
//

import Foundation
import Alamofire



protocol ProductsDataDelegate {
    func productsData(products: [Product])
}

protocol ShowErrorsDelegate {
    func showError(errorString: String?,errorIsHidden: Bool)
}

struct ProductManager {
        
    var productsDataDelegate: ProductsDataDelegate?
    var showErrorsDelegate: ShowErrorsDelegate?
    
    func getProducts()  {
        APICaller.shared.performAPICall(url: productURL, expectedReturnType: Products.self, parameters: nil, method: .get) { (result) in
            switch result {
            case .success(let product):
                if product.products.count < 1 {
                    print("Not products found")
                }else {
                    
                    self.productsDataDelegate?.productsData(products: product.products)
                  
                }
                
            case .failure(.internalServerError):
                print("internal server error")
                
            case .failure(.badURL):
                print("bad url")
            case .failure(.emailAlreadyExist):
                print("Email already exist")
            case .failure(.notFound):
                print("products already exist")
            }
    }
    
}
    
    func addProduct(productName: String!, productPrice: String!, productBrand: String!, productSize: String!, productDescription: String!, productImg: UIImage?, view: UIViewController)  {
       
        if productName.isEmpty && productPrice.isEmpty && productBrand.isEmpty, productSize.isEmpty && productDescription.isEmpty && productImg == nil {
            
            showErrorsDelegate?.showError(errorString: "Please the enter required fields.", errorIsHidden: false)
        }
        else if productName.isEmpty {
            showErrorsDelegate?.showError(errorString: "Please enter the product name.", errorIsHidden: false)
        }
        else if productPrice.isEmpty {
            showErrorsDelegate?.showError(errorString: "Please enter the product price.", errorIsHidden: false)
        
        }
        
        else if productBrand.isEmpty {
            showErrorsDelegate?.showError(errorString: "Please enter the product brand.", errorIsHidden: false)
        }
        else if productDescription.isEmpty {
            showErrorsDelegate?.showError(errorString: "Please enter product's description.", errorIsHidden: false)
        
        }
        else if productImg == nil{
            showErrorsDelegate?.showError(errorString: "Please choose product's image.", errorIsHidden: false)

        }
        else {
            showErrorsDelegate?.showError(errorString: nil, errorIsHidden: true)
            let imgData = productImg!.jpegData(compressionQuality: 1)

            let parameters = [
                "name": productName!,
                "price": productPrice!,
                "brand": productBrand!,
                "size": productSize!,
                "description": productDescription!,
                "productImage": imgData as Any
            ]
            
            APICaller.shared.performAPICall(url: productURL, expectedReturnType: CreatedProduct.self, parameters: parameters, method: .post) { (result) in
                switch result {
                case .success(let product):
                    print(product.productDetails)
                case .failure(.badURL):
                    print("bad url")
                case .failure(.emailAlreadyExist):
                    print("email already exist")
                case .failure(.internalServerError):
                    print("internal server error")
                case .failure(.notFound):
                    print("not found")
                }
            }
            
        }
        
    }
}
