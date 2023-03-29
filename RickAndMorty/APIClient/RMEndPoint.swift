//
//  RMEndPoint.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/29.
//

import Foundation

/// Represents unique API endpoint
@frozen enum RMEndPoint: String {
    /// Endpoint to get character info
    case character // "character"
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
