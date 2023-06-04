//
//  CountryPickerViewController.swift
//  RideApp
//
//  Created by Masud Onikeku on 04/06/2023.
//

import UIKit

class CountryPickerViewController: UIViewController {
    
    
    @IBOutlet weak var closeMark: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var list : [Country] = [Country]()
    var refList : [Country] = [Country]()
    var delegate : CountryPicked?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        configuration()
    }
    
    func setup() {
        
        backView.layer.cornerRadius = 8
        
        textField.becomeFirstResponder()
        backView.layer.borderWidth = 2
        backView.layer.borderColor = Constants.green.cgColor
        
        closeMark.isUserInteractionEnabled = true
        closeMark.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeView)))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(self.changeList), for: .editingChanged)
    }
    
    @objc func changeList(textField:UITextField) {
        
        if textField.text == "" {
            
            refList = list.sorted {$0.name! < $1.name!}
            tableView.reloadData()
            
        }else {
            
            let search = textField.text!
            refList.removeAll()
            for country in list {
                
                if country.name!.lowercased().contains(search) {
                    
                    refList.append(country)
                }
            }
            
            tableView.reloadData()
            
        }
    }
    
    @objc func closeView() {
        
        self.dismiss(animated: true)
    }
    
    
    func configuration() {
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier (fromComponents: [NSLocale.Key.countryCode.rawValue:
                                                                    code])
            let name = NSLocale (localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id)
            let locale = NSLocale.init(localeIdentifier: id)
            let countryCode = locale.object(forKey: NSLocale.Key.countryCode)
            let currencyCode = locale.object(forKey: NSLocale.Key.currencyCode)
            let currencySymbol = locale.object(forKey: NSLocale.Key.currencySymbol)
            
            if name != nil {
                let model = Country(name: name, flag: String.flag (for: code), countryCode: countryCode as? String, extensionCode: NSLocale().extensionCode (countryCode: countryCode as? String))
                
                list.append(model)
                refList = list.sorted {$0.name! < $1.name!}
                
            }
        }
        
        tableView.reloadData()
    }
    
}

extension CountryPickerViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        cell.selectionStyle = .none
        let country = refList[indexPath.row]
        cell.flag.text = country.flag!
        cell.name.text = country.name!
        if let code = country.extensionCode {
            cell.countryCode.text = "+" + code
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = refList[indexPath.row]
        
        self.dismiss(animated: true, completion: {
        
            self.delegate?.picked(country: country)
        })
    }
}

extension CountryPickerViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backView.layer.borderWidth = 2
        backView.layer.borderColor = Constants.green.cgColor
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backView.layer.borderWidth = 0
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}


protocol CountryPicked {
    
    func picked(country: Country)
}
