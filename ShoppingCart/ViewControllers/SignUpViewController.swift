//
//  SignUpViewController.swift
//  ShoppingCart
//
//  Created by Mac on 02/10/2020.
//

import UIKit

class SignUpViewController: UIViewController {

    var um = UserManager()
    
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var emailErrorLbl: UILabel!
    
    @IBOutlet weak var passwordErrorLbl: UILabel!
    
    @IBOutlet weak var confirmPassErrorLbl: UILabel!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    

    @IBOutlet weak var cnfrmPassTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        um.signupDelegate = self
        um.changeViewDelegate = self
        um.showAlertViewDelegate = self
        viewDesign()
    }
    
    func viewDesign()  {
        
        
        signupButton.layer.cornerRadius = CGFloat(20)
        emailErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        confirmPassErrorLbl.isHidden = true
    }
    
    
    @IBAction func signupTapped(_ sender: UIButton) {
        self.um.signup(email: emailTxtField.text!, password: passwordTxtField.text!, cnfrmPass: cnfrmPassTxtField.text!)
    }
    
    
}

extension SignUpViewController: UserManagerSignUpDelegate, ChangeViewDelegate, ShowAlertViewDelegate {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showView(storyboardID: String) {
        let hvc = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(hvc!, animated: true)
    }
    
    func showSignupErrors(email: String?, password: String?, confirmPass: String?, emailErrorIsHidden: Bool, passErrorIsHidden: Bool, cnfrmPassIsHidden: Bool) {
        emailErrorLbl.isHidden = emailErrorIsHidden
        passwordErrorLbl.isHidden = passErrorIsHidden
        confirmPassErrorLbl.isHidden = cnfrmPassIsHidden
        emailErrorLbl.text = email
        passwordErrorLbl.text = password
        confirmPassErrorLbl.text = confirmPass
        
    }
    
    
}
