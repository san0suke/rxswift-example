//
//  HomeViewController.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 01/11/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
//        let rememberMeStack = UIStackView(arrangedSubviews: [rememberSwitchLabel, rememberSwitch])
//        rememberMeStack.spacing = 15
//        rememberMeStack.axis = .horizontal
//        
//        let verticalStackView = UIStackView(arrangedSubviews: [formTitle, loginTextField, passwordTextField,
//                                                               rememberMeStack, loginButton])
//        verticalStackView.axis = .vertical
//        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
//        verticalStackView.spacing = 15
//        verticalStackView.alignment = .center
//        
//        view.addSubview(verticalStackView)
//        
//        NSLayoutConstraint.activate([
//            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            formTitle.widthAnchor.constraint(equalToConstant: 250),
//            loginTextField.widthAnchor.constraint(equalToConstant: 250),
//            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
//            loginButton.widthAnchor.constraint(equalToConstant: 250)
//        ])
    }
    
    private func setupBindings() {
        
    }
}
