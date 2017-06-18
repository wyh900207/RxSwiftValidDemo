//
//  SImpleValidViewModel.swift
//  RxSwiftValidDemo
//
//  Created by HomerIce on 2017/6/18.
//  Copyright © 2017年 HomerIce. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let minUsernameLength = 5
let minPasswordLength = 5

class SimpleValidViewModel {
    
    let validUsernameObservable: Driver<Bool>
    let validPasswordObservable: Driver<Bool>
    let bothValidObservable: Driver<Bool>
    
    init(input: (username: Driver<String>, password: Driver<String>)) {
        
        validUsernameObservable = input.username
            .map {
                $0.characters.count >= minUsernameLength
            }
        
        validPasswordObservable = input.password
            .map {
                $0.characters.count >= minPasswordLength
            }
        
        bothValidObservable = Driver.combineLatest(validUsernameObservable, validPasswordObservable) {
                return $0 && $1
            }
    }
}
