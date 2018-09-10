//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/3/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    public var username = Variable<String>("")
    var password = Variable<String>("")
    
    var isValid : Observable<Bool> {
        return Observable.combineLatest(username.asObservable(), password.asObservable()) { email, password in
            email.count >= 1 && password.count >= 1
        }
    }
    
}
