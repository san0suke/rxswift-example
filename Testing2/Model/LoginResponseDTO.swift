//
//  LoginResponse.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 31/10/24.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let token: String
    let user: UserDTO
}
