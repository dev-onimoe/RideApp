//
//  AuthViewModel.swift
//  RideApp
//
//  Created by Masud Onikeku on 04/06/2023.
//

import Foundation

class AuthViewModel {
    
    var signinDone : Observable<Response?> = Observable(nil)
    var signupDone : Observable<Response?> = Observable(nil)
    var userCheck : Observable<Response?> = Observable(nil)
    
    func checkUser(phone: String) {
        
        Service.requestData(url: "Users/\(phone)", method: .get, parameters: nil, completion: {[weak self] response in
            
            guard let self = self else {return}
            
            self.userCheck.value = response
        })
    }
    
    func register(user: [String : [String : String]], phone: String) {
        
        Service.requestData(url: "Users/"+phone, method: .put, parameters: user, completion: {[weak self] response in
            
            guard let self = self else {return}
            
            self.signupDone.value = response
        })
    }
}
