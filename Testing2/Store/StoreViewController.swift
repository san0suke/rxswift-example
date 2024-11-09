//
//  StoreViewController.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 08/11/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = StoreViewModel()
    private let disposeBag = DisposeBag()

    private let statusBarView = StatusBarView()
    private let tableView = UITableView()
    private let tapCountManager: TapCountManagerProtocol = TapCountManager.shared
    private let tapPowersManager: TapPowersManagerProtocol = TapPowersManager.shared
    
    private let items: [StoreItem] = [
        StoreItem(itemEnum: .FisrtPlusTap, iconName: "hand.tap", name: "+3 taps per tap", price: 100),
        StoreItem(itemEnum: .FirstTapFactory, iconName: "person.3.sequence", name: "+1 taps/second tap factory", price: 300),
        StoreItem(itemEnum: .SecondPlusTap, iconName: "hand.tap", name: "+50 taps per tap", price: 1000),
        StoreItem(itemEnum: .SecondTapFactory, iconName: "person.3.sequence", name: "+50 taps/second tap factory", price: 10000),
        StoreItem(itemEnum: .ThirdPlusTap, iconName: "hand.tap", name: "+1000 taps per tap", price: 100000),
        StoreItem(itemEnum: .ThirdTapFactory, iconName: "person.3.sequence", name: "+1000 taps/second factory", price: 500000),
        StoreItem(itemEnum: .Victory, iconName: "trophy", name: "Win the game", price: 1500000),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusBarView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: statusBarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StoreLineTableViewCell.self, forCellReuseIdentifier: "StoreLineCell")
    }
    
    private func canBuy(_ price: Int) -> Bool {
        return tapCountManager.tapCount.value >= price
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let item = items[indexPath.row]
        
        if !canBuy(item.price) {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreLineCell", for: indexPath) as! StoreLineTableViewCell
        let item = items[indexPath.row]
        cell.configure(with: UIImage(systemName: item.iconName), title: item.name, price: "\(item.price) Taps")
        
        if canBuy(item.price) {
            cell.isUserInteractionEnabled = true
            cell.contentView.alpha = 1.0
        } else {
            cell.isUserInteractionEnabled = false
            cell.contentView.alpha = 0.5
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        print("Tapped on item: \(item)")
        
        tapCountManager.decrease(item.price)
        tapPowersManager.add(item)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
