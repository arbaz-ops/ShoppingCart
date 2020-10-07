//
//  DetailViewController.swift
//  ShoppingCart
//
//  Created by Mac on 05/10/2020.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var shopButton: UIButton!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopButton.layer.cornerRadius = shopButton.frame.size.width / 2
        shopButton.layer.masksToBounds = true
        
        productImageView.setImageWith(URL(string: localhost + product!.productImage)!, placeholderImage: UIImage(named: "p1"))
        productName.text = product?.name
        productDescription.numberOfLines = 0
        productDescription.clipsToBounds = true
        productDescription.adjustsFontForContentSizeCategory = true
        productDescription.text = product?.description
        // Do any additional setup after loading the view.
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
