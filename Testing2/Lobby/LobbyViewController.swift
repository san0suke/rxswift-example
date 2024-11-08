//
//  LobbyViewController.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 01/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class LobbyViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let statusBarView = StatusBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
