//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/30.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
