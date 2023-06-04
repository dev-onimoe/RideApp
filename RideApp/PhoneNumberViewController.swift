//
//  PhoneNumberViewController.swift
//  RideApp
//
//  Created by Masud Onikeku on 03/06/2023.
//

import UIKit

class PhoneNumberViewController: UIViewController, CountryPicked {
    
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var dropDownStack: UIStackView!
    
    let viewModel = AuthViewModel()
    var phone = ""
    var country = Country(name: "Nigeria", flag: "🇳🇬", countryCode: "NGA", extensionCode: "234")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setup()
        binds()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setup()
    }
    
    func setup() {
        
        dropDownStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCountry)))
        
        signinBtn.layer.cornerRadius = 8
        backView.layer.cornerRadius = 8
    }
    
    func binds() {
        
        viewModel.userCheck.bind(completion: {[weak self] response in
            
            DispatchQueue.main.async {
                self?.removeLoader()
                
                if let response = response {
                    
                    if response.check {
                        
                        if let user = response.object {
                            // take to home
                            let nextVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                            nextVc.modalPresentationStyle = .fullScreen
                            self?.present(nextVc, animated: true)
                            
                        }else {
                            
                            //take to signup
                            let nextVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mail") as! MailViewController
                            nextVc.user = User(firstName: nil, lastName: nil, phone: self?.phone, email: nil)
                            self?.navigationController?.pushViewController(nextVc, animated: true)
                            
                        }
                        
                    }else {
                        
                        self?.showAlert(message: response.description)
                    }
                }
            }
        })
    }
    
    @objc func openCountry() {
        
        let nextVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "country") as! CountryPickerViewController
        nextVc.modalPresentationStyle = .fullScreen
        nextVc.delegate = self
        self.present(nextVc, animated: true)
    }

    @IBAction func signInAction(_ sender: UIButton) {
        
        if textfield.text == "" {
            
            self.showAlert(message: "Please input phone number")
            
        }else {
            
            if textfield.text!.count < 10 {
                
                self.showAlert(message: "Phone number is invalid")
            }else {
                
                phone = "+\(country.extensionCode ?? "234")" + textfield.text!
                print(phone)
                self.showloader()
                viewModel.checkUser(phone: phone)
            }
            
            
        }
    }
    
    func picked(country: Country) {
        self.country = country
        
        for views in dropDownStack.arrangedSubviews {
            
            if let v = views as? UILabel {
                
                v.text = country.flag!
            }
        }
    }
    
    
}
