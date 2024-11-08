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

class HomeViewController: UITabBarController {
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let firstTab = UIViewController()
        firstTab.view.backgroundColor = .white
        firstTab.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let secondTab = LobbyViewController()
        secondTab.view.backgroundColor = .white
        secondTab.tabBarItem = UITabBarItem(title: "Lobby", image: UIImage(systemName: "house"), tag: 1)
        
        let thirdTab = UIViewController()
        thirdTab.view.backgroundColor = .white
        thirdTab.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        viewControllers = [firstTab, secondTab, thirdTab]
        
        selectedIndex = 1
    }
    
    private func setupBindings() {
        
    }
}
