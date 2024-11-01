//
//  UserDTO.swift
//  Testing2
//
//  Created by Robson Cesar de Siqueira on 31/10/24.
//

import Foundation

struct UserDTO: Codable {
    let Id: Int
    let Name: String
    let Email: String
    let Level: Int
    let Coins: Int
    let Gems: Int
    let Xp: Int
    let LastTimeOnline: Date?
    let RatedTheGame: Bool?
}
