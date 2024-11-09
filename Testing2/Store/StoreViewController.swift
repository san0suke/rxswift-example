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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupBindings()
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
    
    private func setupBindings() {
        viewModel.tapCount
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.showWinDialog
            .subscribe { _ in
                self.presentWinDialog()
            }
            .disposed(by: disposeBag)
    }
    
    private func presentWinDialog() {
        let alertController = UIAlertController(title: "Congratulations!", message: "You won the game! Thank you for playing!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let item = viewModel.items[indexPath.row]
        return viewModel.canBuy(item.price) ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreLineCell", for: indexPath) as! StoreLineTableViewCell
        let item = viewModel.items[indexPath.row]
        cell.configure(with: UIImage(systemName: item.iconName), title: item.name, price: "\(item.price) Taps")
        
        if viewModel.canBuy(item.price) {
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
        let item = viewModel.items[indexPath.row]
        viewModel.purchase(item: item)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
