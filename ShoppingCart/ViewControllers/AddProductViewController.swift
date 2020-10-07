//
//  AddProductViewController.swift
//  ShoppingCart
//
//  Created by Mac on 06/10/2020.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var chooseImgButton: UIButton!
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var productPriceTxt: UITextField!
    @IBOutlet weak var productBrandTxt: UITextField!
    @IBOutlet weak var productSizeTxt: UITextField!
    @IBOutlet weak var productDescription: UITextField!
    
    @IBOutlet weak var productImgView: UIImageView!
    
    var imgPicker = UIImagePickerController()
    
    var pm = ProductManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pm.showErrorsDelegate = self
        imgPicker.delegate = self
        addButton.layer.cornerRadius = 20
        chooseImgButton.layer.cornerRadius = 20
        errorLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func chooseImgTapped(_ sender: Any) {
        
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true, completion: nil)
    }
    
    
    @IBAction func addProductTapped(_ sender: Any) {
        pm.addProduct(productName: productNameTxt.text!, productPrice: productPriceTxt.text!, productBrand: productBrandTxt.text!, productSize: productSizeTxt.text!, productDescription: productDescription.text!, productImg: productImgView.image, view: self)
        
    }
    

}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ShowErrorsDelegate {
    func showError(errorString: String?, errorIsHidden: Bool) {
        errorLbl.isHidden = errorIsHidden
        errorLbl.text = errorString
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            productImgView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}


