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
    func decrease(_ itemPrice: Int)
}

fileprivate let tapCountKey = "tapCount"

class TapCountManager: TapCountManagerProtocol {
    
    static let shared = TapCountManager()
    
    private(set) var tapCount = BehaviorRelay<Int>(value: UserDefaults.standard.integer(forKey: tapCountKey))
    
    private init() {}
    
    func incrementTapCount() {
        saveTap(count: tapCount.value + TapPowersManager.shared.increasePerTap)
    }
    
    func decrease(_ itemPrice: Int) {
        saveTap(count: tapCount.value - itemPrice)
    }
    
    private func saveTap(count: Int) {
        tapCount.accept(count)
        UserDefaults.standard.set(count, forKey: tapCountKey)
    }
}
