//
//  UserDefaultsData.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 01/11/24.
//

import Foundation

class UserDefaultsData {
    private var userDefault: UserDefaults
    
    var rememberMe: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "rememberMe")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "rememberMe")
        }
    }
    
    var userData: LoginResponseDTO? {
        get {
            if let data = UserDefaults.standard.data(forKey: "loginResponse"),
               let decoded = try? JSONDecoder().decode(LoginResponseDTO.self, from: data) {
                return decoded
            }
            return nil
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "loginResponse")
            }
        }
    }
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
}
