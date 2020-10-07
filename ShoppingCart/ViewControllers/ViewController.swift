//
//  ViewController.swift
//  ShoppingCart
//
//  Created by Mac on 02/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var um = UserManager()
   
    
    let email:String = "arbazchughtai55@gmail.com"
    let password: String = "Bepatient1@"
    var isLoggedIn: Bool = false
    
    //Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    //Errors Label
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    
    //Text Fields
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        um.loginDelegate = self
        um.changeViewDelegate = self
        um.showAlertViewDelegate = self
        
        viewDesign()
        if UserDefaults.standard.dictionary(forKey: userSession) != nil {
            let hvc = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(hvc!, animated: true)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func viewDesign()  {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        loginButton.layer.cornerRadius = CGFloat(20)
        signupButton.layer.cornerRadius = CGFloat(20)
        emailErrorLbl.isHidden = true
        passwordErrorLbl.isHidden = true
        
        
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        self.um.login(email: emailTxtField.text!, password: passwordTxtField.text!)
        
    }
    
    
    
    @IBAction func signupTapped(_ sender: Any) {
        let svc = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController
        
        self.navigationController?.pushViewController(svc!, animated: true)
    }
    
    
    
}

extension ViewController: UserManagerLoginDelegate, ChangeViewDelegate, ShowAlertViewDelegate {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showView(storyboardID: String) {
        let hvc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(hvc!, animated: true)
    }
    
    
    
    func showLoginErrors(email: String?, password: String?, emailErrorIsHidden: Bool, passErrorIsHidden: Bool) {
        emailErrorLbl.isHidden = emailErrorIsHidden
        passwordErrorLbl.isHidden = passErrorIsHidden
        emailErrorLbl.text = email
        passwordErrorLbl.text = password
        
    }
    
    
}
