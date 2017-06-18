//
//  ViewController.swift
//  RxSwiftValidDemo
//
//  Created by HomerIce on 2017/6/18.
//  Copyright © 2017年 HomerIce. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var validUsernameLabel: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var validPasswordLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        validUsernameLabel.text = "Username has to be at least 5"
        validPasswordLabel.text = "Password has to be at least 5"
        
        let viewModel = SimpleValidViewModel(input: (username: usernameTF.rx.text.orEmpty.asDriver(), password: passwordTF.rx.text.orEmpty.asDriver()))
        
        viewModel.bothValidObservable
            .drive(actionButton.rx.isEnabled)
            .addDisposableTo(disposebag)
        
        viewModel.validUsernameObservable
            .drive(validUsernameLabel.rx.isHidden)
            .addDisposableTo(disposebag)
        
        viewModel.validPasswordObservable
            .drive(validPasswordLabel.rx.isHidden)
            .addDisposableTo(disposebag)
        
        viewModel.validUsernameObservable
            .drive(passwordTF.rx.isEnabled)
            .addDisposableTo(disposebag)
        
        actionButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.tapedActionButton()
            })
            .addDisposableTo(disposebag)
    }

}

extension ViewController {
    
    fileprivate func tapedActionButton() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}


