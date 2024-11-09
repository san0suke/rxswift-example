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
    
}

class TapPowersManager: TapPowersManagerProtocol {
    
    static let shared = TapPowersManager()
    
    private init() {}
}
