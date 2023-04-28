//
//  RMSearchResultsViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/28.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
