//
//  LoginViewModel.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 31/10/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel {
    
    private var networkService: NetworkService
    
    let username = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let rememberMe = BehaviorSubject<Bool>(value: false)
    let isLoginButtonEnabled: Observable<Bool>
    
    init(networkService: NetworkService = NetworkService(baseURL: "http://localhost:7071/api/")) {
        self.networkService = networkService
        
        isLoginButtonEnabled = Observable.combineLatest(username, password)
            .map { !$0.isEmpty && !$1.isEmpty }
    }
    
    func login() -> Observable<LoginResponseDTO> {
        let parameters: [String: Any] = [
            "email": try! username.value(),
            "password": try! password.value()
        ]
        
        return networkService.post(endpoint: "LoginFunction", parameters: parameters)
    }
}
