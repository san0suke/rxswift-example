//
//  StatusBarView.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 08/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class StatusBarView: UIView {
    
    var tapCountManager: TapCountManagerProtocol = TapCountManager.shared
    private let disposeBag = DisposeBag()
    
    let tapLabelScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        backgroundColor = .systemGray5
        addSubview(tapLabelScore)
        
        NSLayoutConstraint.activate([
            tapLabelScore.centerXAnchor.constraint(equalTo: centerXAnchor),
            tapLabelScore.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        setupBindings()
    }
    
    private func setupBindings() {
        tapCountManager.tapCount
            .map { "Taps: \($0)" }
            .bind(to: tapLabelScore.rx.text)
            .disposed(by: disposeBag)
    }
}
