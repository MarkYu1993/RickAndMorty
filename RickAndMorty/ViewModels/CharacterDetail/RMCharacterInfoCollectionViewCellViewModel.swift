//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/12.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
}
