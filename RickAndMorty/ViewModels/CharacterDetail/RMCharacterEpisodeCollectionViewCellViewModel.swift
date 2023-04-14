//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/12.
//

import Foundation

protocol RMEpisodeDataRender {
    var episode: String { get }
    var name: String { get }
    var airDate: String? { get }
}

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    
    /// 因為collectionViewCell每次轉動時都會觸發，而資料只需抓取一次，所以設定開關
    private var isFetching = false
    
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else { return }
            dataBlock?(model)
        }
    }
    
    
    // MARK: - Init
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    // MARK: - Public
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl,
              let request = RMRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        RMService.shared.execute(request,
                                 expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}