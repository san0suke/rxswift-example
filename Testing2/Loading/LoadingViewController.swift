//
//  LoadingViewController.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 01/11/24.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.frame = UIScreen.main.bounds
    }
    
    func show(in viewController: UIViewController) {
        viewController.addChild(self)
        view.frame = viewController.view.bounds
        viewController.view.addSubview(view)
        didMove(toParent: self)
    }
    
    func hideLoadingScreen() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
