//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let airDate: String?
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
