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
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.startTapFactory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let firstTab = StoreViewController()
        firstTab.view.backgroundColor = .white
        firstTab.tabBarItem = UITabBarItem(title: "Store", image: UIImage(systemName: "storefront"), tag: 0)
        
        let secondTab = LobbyViewController()
        secondTab.view.backgroundColor = .white
        secondTab.tabBarItem = UITabBarItem(title: "Lobby", image: UIImage(systemName: "house"), tag: 1)
        
        viewControllers = [firstTab, secondTab]
        
        selectedIndex = 1
    }
}
