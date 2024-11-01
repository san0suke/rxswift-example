import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    // UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let rememberMeSwitch: UISwitch = {
        let rememberSwitch = UISwitch()
        return rememberSwitch
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember Me"
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.isEnabled = false // Desabilitado inicialmente
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Adicionando subviews
        let stackView = UIStackView(arrangedSubviews: [titleLabel, loginTextField, passwordTextField, rememberMeSwitch, rememberMeLabel, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupBindings() {
        // Observa os campos de texto e habilita o botão Login somente se ambos estiverem preenchidos
        Observable.combineLatest(loginTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) { login, password in
            return !login.isEmpty && !password.isEmpty
        }
        .bind(to: loginButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        // Observa o clique no botão Login
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                let login = self.loginTextField.text ?? ""
                let password = self.passwordTextField.text ?? ""
                let rememberMe = self.rememberMeSwitch.isOn
                
                print("Login: \(login), Password: \(password), Remember Me: \(rememberMe)")
                // Aqui, você pode implementar a lógica de autenticação
            })
            .disposed(by: disposeBag)
    }
}
