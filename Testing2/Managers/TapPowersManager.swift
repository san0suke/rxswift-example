//
//  TapPowersManager.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 09/11/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol TapPowersManagerProtocol {
    var increasePerTap: Int { get }
    var factoryIncreaseTap: Int { get }
    func add(_ item: StoreItem)
}

fileprivate let increasePerTapKey = "increasePerTap"
fileprivate let factoryIncreaseTapKey = "factoryIncreaseTap"

class TapPowersManager: TapPowersManagerProtocol {
    
    static let shared = TapPowersManager()
    
    var increasePerTap = UserDefaults.standard.integer(forKey: increasePerTapKey)
    var factoryIncreaseTap = UserDefaults.standard.integer(forKey: factoryIncreaseTapKey)
    
    private init() {
        increasePerTap = increasePerTap == 0 ? 1 : increasePerTap
    }
    
    func add(_ item: StoreItem) {
        switch (item.itemEnum) {
        case .FisrtPlusTap:
            increasePerTapCount(3)
        case .SecondPlusTap:
            increasePerTapCount(50)
        case .ThirdPlusTap:
            increasePerTapCount(1000)
        case .FirstTapFactory:
            increaseFactoryAutoTap(1)
        case .SecondTapFactory:
            increaseFactoryAutoTap(150)
        case .ThirdTapFactory:
            increaseFactoryAutoTap(10000)
        default:
            break
        }
    }
    
    private func increasePerTapCount(_ count: Int) {
        increasePerTap += count
        UserDefaults.standard.set(increasePerTap, forKey: increasePerTapKey)
    }
    
    private func increaseFactoryAutoTap(_ count: Int) {
        factoryIncreaseTap += count
        UserDefaults.standard.set(factoryIncreaseTap, forKey: factoryIncreaseTapKey)
    }
}
