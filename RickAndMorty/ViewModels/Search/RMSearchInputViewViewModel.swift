//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/26.
//

import Foundation

final class RMSearchInputViewViewModel {
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    // MARK: - Public
    /*
     case character // name || status || gender
     case episode   // name
     case location  // name || type
     */
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character:
            return true
        case .episode:
            return false
        case .location:
            return true
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .episode:
            return "Episode Title"
        case .location:
            return "Location Name"
        }
    }
}