//
//  StoreViewModel.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 08/11/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class StoreViewModel {
    
    private let tapCountManager: TapCountManagerProtocol
    private let tapPowersManager: TapPowersManagerProtocol
    
    let items: [StoreItem]
    let tapCount: BehaviorRelay<Int>
    let showWinDialog = PublishSubject<Void>()
    
    init(tapCountManager: TapCountManagerProtocol = TapCountManager.shared,
         tapPowersManager: TapPowersManagerProtocol = TapPowersManager.shared) {
        self.tapCountManager = tapCountManager
        self.tapPowersManager = tapPowersManager
        self.tapCount = tapCountManager.tapCount
        self.items = [
            StoreItem(itemEnum: .FisrtPlusTap, iconName: "hand.tap", name: "+3 taps per tap", price: 100),
            StoreItem(itemEnum: .FirstTapFactory, iconName: "person.3.sequence", name: "+1 taps/second tap factory", price: 300),
            StoreItem(itemEnum: .SecondPlusTap, iconName: "hand.tap", name: "+50 taps per tap", price: 1000),
            StoreItem(itemEnum: .SecondTapFactory, iconName: "person.3.sequence", name: "+150 taps/second tap factory", price: 10000),
            StoreItem(itemEnum: .ThirdPlusTap, iconName: "hand.tap", name: "+1000 taps per tap", price: 100000),
            StoreItem(itemEnum: .ThirdTapFactory, iconName: "person.3.sequence", name: "+10000 taps/second factory", price: 500000),
            StoreItem(itemEnum: .Victory, iconName: "trophy", name: "Win the game", price: 1500000)
        ]
    }
    
    func canBuy(_ price: Int) -> Bool {
        return tapCount.value >= price
    }
    
    func purchase(item: StoreItem) {
        switch item.itemEnum {
        case .Victory:
            showWinDialog.onNext(())
        default:
            tapCountManager.decrease(item.price)
            tapPowersManager.add(item)
        }
    }
}
