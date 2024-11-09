//
//  HomeViewModel.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 09/11/24.
//

import Foundation

class HomeViewModel {
    
    func startTapFactory() {
        TapFactoryManager.shared.startTapIncrementLoop()
    }
}
