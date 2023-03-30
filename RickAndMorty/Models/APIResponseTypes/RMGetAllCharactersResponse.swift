//
//  GetCharactersResponse.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/29.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [RMCharacter]
}
