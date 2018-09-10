//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/3/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextFieldCustom: TextFieldCustom!
    @IBOutlet weak var passTextFieldCustom: TextFieldCustom!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBAction func onBack(segue: UIStoryboardSegue) {}
    
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = userNameTextFieldCustom.textfieldView.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.username)
        _ = passTextFieldCustom.textfieldView.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.password)
        _ = loginViewModel.isValid.bind(to: buttonLogin.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext: {invalid in
            self.buttonLogin.backgroundColor = invalid ? UIColor.red : UIColor.gray
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        buttonLogin.rx.tap.bind {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let listViewController = storyBoard.instantiateViewController(withIdentifier: "ListViewController")
            self.present(listViewController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

