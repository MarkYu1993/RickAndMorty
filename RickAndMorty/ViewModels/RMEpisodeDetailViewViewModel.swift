//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/18.
//

import UIKit

class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print("yyy")
            case .failure(let failure):
                print("yyy")
            }
        }
    }
}
