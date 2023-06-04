//
//  ViewController.swift
//  RideApp
//
//  Created by Masud Onikeku on 03/06/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            
            /*let nav = UINavigationController(rootViewController: )
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .fullScreen*/
            
            let nextVc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "phone") as! PhoneNumberViewController
            let nav = UINavigationController(rootViewController: nextVc )
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .fullScreen
            //nextVc.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
            
            //self.present(nextVc, animated: true)
        })
    }


}

