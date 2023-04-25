//
//  RMGetAllLocationsResponse.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/25.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    let info: Info
    let results: [RMLocation]
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
