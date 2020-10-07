//
//  ProductTableViewCell.swift
//  ShoppingCart
//
//  Created by Mac on 05/10/2020.
//

import UIKit
import AFNetworking

class ProductTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(product:Product){
        productName.text = product.name
        productPrice.text = "Rs.\(product.price)"
        productImageView.setImageWith(URL(string: localhost + product.productImage)!, placeholderImage: UIImage(named: "p1"))
        
        productDescription.text = product.description
    }
}
