//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/26.
//

import Foundation

// Responsibilities
// - show search results
// - show no results view
// - kick off API requests

final class RMSearchViewViewModel {
    let config: RMSearchViewController.Config
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
}
