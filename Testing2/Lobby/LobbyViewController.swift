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
    
    private let tapHereLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap me!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let tapView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.layer.borderColor = UIColor.black.cgColor
        uiView.layer.borderWidth = 2
        
        return uiView
    }()
    
    private let tapCounter = BehaviorRelay<Int>(value: TapCountManager.shared.tapCount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        tapView.addSubview(tapHereLabel)
        view.addSubview(statusBarView)
        view.addSubview(tapView)
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 50),
            tapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tapView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor),
            tapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tapHereLabel.centerXAnchor.constraint(equalTo: tapView.centerXAnchor),
            tapHereLabel.centerYAnchor.constraint(equalTo: tapView.centerYAnchor),
        ])
    }
    
    private func setupBindings() {
        let tapGesture = UITapGestureRecognizer()
        tapView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .do(onNext: { _ in
                print("Tapped!")
                let newCount = TapCountManager.shared.incrementTapCount()
                self.tapCounter.accept(newCount)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        tapCounter
            .map { "Taps: \($0)" }
            .bind(to: statusBarView.tapLabelScore.rx.text)
            .disposed(by: disposeBag)
    }
}
