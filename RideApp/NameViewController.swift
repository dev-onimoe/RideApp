//
//  NameViewController.swift
//  RideApp
//
//  Created by Masud Onikeku on 04/06/2023.
//

import UIKit


class NameViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func GoToHome(_ sender: UIButton) {
        
        if firstName.text!.isEmpty || lastName.text!.isEmpty {
            
            self.showAlert(message: "Please input all fields")
        }else {
            
            let dict = [user!.phone! : ["firstName" : firstName.text!, "lastName" : lastName.text!, "email" : user!.email!, "phone" : user!.phone!]]
            self.showloader()
            viewModel.register(user: dict, phone: user!.phone!)
        }
    }
    
    @IBOutlet weak var closeArrow: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var btnConstraint: NSLayoutConstraint!
    
    var user : User?
    var keyHeight = 0.0
    
    
    let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        continueBtn.layer.cornerRadius = 12
        
        binds()
        setup()
    }
    
    func setup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        firstName.delegate = self
        lastName.delegate = self
        
        closeArrow.isUserInteractionEnabled = true
        closeArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
    }
    
    @objc func goBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func binds() {
        
        viewModel.signupDone.bind(completion: {[weak self] response in
            
            
            
            DispatchQueue.main.async {
                self?.removeLoader()
                
                if let response = response {
                    
                    if response.check {
                        
                        let nextVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "home") as! HomeViewController
                        nextVc.modalPresentationStyle = .fullScreen
                        self?.present(nextVc, animated: true)
                        
                    }else {
                        
                        self?.showAlert(message: response.description)
                    }
                }
            }
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if keyHeight == 0.0 {
                keyHeight = keyboardSize.height
            }
            //danceView.frame.origin.y = vc!.view.frame.height - (keyHeight + danceView.frame.height)
            btnConstraint.constant = keyHeight + 86
            
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        btnConstraint.constant = 24
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}
