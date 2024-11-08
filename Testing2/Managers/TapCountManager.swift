//
//  TapCountManager.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 08/11/24.
//

import Foundation

protocol TapCountManagerProtocol {
    var tapCount: Int { get set }
    func incrementTapCount() -> Int
}

class TapCountManager: TapCountManagerProtocol {
    
    static let shared = TapCountManager()
    private let tapCountKey = "tapCount"
    
    var tapCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: tapCountKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tapCountKey)
        }
    }
    
    private init() {}
    
    func incrementTapCount() -> Int {
        tapCount += 1
        return tapCount
    }
}
