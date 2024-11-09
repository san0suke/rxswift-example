//
//  TapFactoryManager.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 09/11/24.
//

import Foundation

class TapFactoryManager {
    
    static let shared = TapFactoryManager()
    
    private var timer: Timer?
    
    private init() {}
    
    func startTapIncrementLoop() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementTaps), userInfo: nil, repeats: true)
    }
    
    func stopTapIncrementLoop() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func incrementTaps() {
        let tapCount = TapPowersManager.shared.factoryIncreaseTap + TapCountManager.shared.tapCount.value
        TapCountManager.shared.tapCount.accept(tapCount)
    }
}
