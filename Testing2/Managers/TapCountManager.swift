//
//  TapCountManager.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 08/11/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol TapCountManagerProtocol {
    var tapCount: BehaviorRelay<Int> { get }
    func incrementTapCount()
}

class TapCountManager: TapCountManagerProtocol {
    
    static let shared = TapCountManager()
    
    private(set) var tapCount = BehaviorRelay<Int>(value: UserDefaults.standard.integer(forKey: "tapCount"))
    
    private let tapCountKey = "tapCount"
    private init() {}
    
    func incrementTapCount() {
        let newCount = tapCount.value + 1
        tapCount.accept(newCount)
        UserDefaults.standard.set(newCount, forKey: tapCountKey)
    }
}
