//
//  LoginViewController.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 31/10/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    private let formTitle: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.isEnabled = false
        
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let rememberSwitch: UISwitch = {
        let rememberSwitch = UISwitch()
        return rememberSwitch
    }()
    
    private let rememberSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        return label
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    private let guestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter as guest", for: .normal)
        
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let loadingVC: LoadingViewController = {
        return LoadingViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if viewModel.hasRememberMeSave() {
            navigateToHome()
            return
        }
    }
    
    private func setupUI() {
        let rememberMeStack = UIStackView(arrangedSubviews: [rememberSwitchLabel, rememberSwitch])
        rememberMeStack.spacing = 15
        rememberMeStack.axis = .horizontal
        
        let verticalStackView = UIStackView(arrangedSubviews: [formTitle, loginTextField, passwordTextField,
                                                               rememberMeStack, loginButton, orLabel, guestButton])
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 15
        verticalStackView.alignment = .center
        
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            formTitle.widthAnchor.constraint(equalToConstant: 250),
            loginTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            guestButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupBindings() {
        loginTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        rememberSwitch.rx.isOn
            .bind(to: viewModel.rememberMe)
            .disposed(by: disposeBag)
        
        viewModel.isLoginButtonEnabled
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .flatMapLatest { [unowned self] in
                showLoadingScreen()
                
                return self.viewModel.login()
                    .catchError { error in
                        self.presentErrorDialog()
                        print("Login error: \(error.localizedDescription)")
                        return Observable.empty()
                    }
            }
            .subscribe (onNext: { response in
                print("Response: \(response.token)")
                self.navigateToHome()
            }, onError: { error in
                self.presentErrorDialog()
                print("Error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
        
        guestButton.rx.tap
            .do { _ in
                print("taping guest")
                self.viewModel.loginAsGuest()
            }
            .subscribe { _ in
                self.navigateToHome()
            }
            .disposed(by: disposeBag)
    }
    
    private func presentErrorDialog() {
        loadingVC.hideLoadingScreen()
        
        let alert = UIAlertController(title: "Alerta", message: "Login or Password invalid!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToHome() {
        let homeViewController = HomeViewController()
        guard let window = view.window?.windowScene?.keyWindow else { return }
                
        window.rootViewController = UINavigationController(rootViewController: homeViewController)
        UIView.transition(with: window, duration: 0.5, options: [.transitionFlipFromRight], animations: nil, completion: nil)
    }
    
    func showLoadingScreen() {
        loadingVC.show(in: self)
    }
}
