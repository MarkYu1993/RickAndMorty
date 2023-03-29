//
//  RMService.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/29.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    /// Shared singletion instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Call back with data or error
    public func execute(_ request: RMRequest, completion: @escaping() -> Void) {
        
    }
}
