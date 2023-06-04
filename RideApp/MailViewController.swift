//
//  MailViewController.swift
//  RideApp
//
//  Created by Masud Onikeku on 04/06/2023.
//

import UIKit

class MailViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func GoToName(_ sender: UIButton) {
        
        if textField.text!.isEmpty {
            
            self.showAlert(message: "Please input your email")
        }else {
            
            let nextVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "name") as! NameViewController
            nextVc.user = User(firstName: nil, lastName: nil, phone: user?.phone ?? "", email: textField.text ?? "")
            self.navigationController?.pushViewController(nextVc, animated: true)
        }
        
    }
    
    var user : User?
    var keyHeight = 0.0
    
    
    @IBOutlet weak var backArrow: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var btnConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        continueBtn.layer.cornerRadius = 12
        
        setup()
    }
    
    func setup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textField.delegate = self
        
        backArrow.isUserInteractionEnabled = true
        backArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
    }
    
    @objc func goBack() {
        
        self.navigationController?.popViewController(animated: true)
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
