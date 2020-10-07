//
//  HomeViewController.swift
//  ShoppingCart
//
//  Created by Mac on 04/10/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var pm = ProductManager()
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addProductTapped))
        pm.productsDataDelegate = self
        pm.getProducts()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
   
    
    @objc func logoutTapped() { 
        UserDefaults.standard.removeObject(forKey: userSession)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addProductTapped() {
        let advc = storyboard?.instantiateViewController(identifier: "AddProductViewController") as? AddProductViewController
        
        present(advc!, animated: true, completion: nil)
    }
  

}



extension HomeViewController: ProductsDataDelegate {
    func productsData(products: [Product]) {
        self.products = products
        tableView.reloadData()
    }
    
    

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "productCell") as? ProductTableViewCell
//        productCell?.product = products[indexPath.row]
       
        productCell?.setData(product: products[indexPath.row])
        
        return productCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        dvc?.product = products[indexPath.row]
        navigationController?.pushViewController(dvc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}

