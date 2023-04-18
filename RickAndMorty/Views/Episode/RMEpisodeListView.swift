//
//  RMEpisodeListView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/18.
//
import UIKit

protocol RMEpisodeListViewDelegate: AnyObject {
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode)
}

/// View that handles showing list of episodes, loader, etc.
final class RMEpisodeListView: UIView {
    
    public weak var delegate: RMEpisodeListViewDelegate?
    
    private let viewModel = RMEpisodeListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // 設定滾動方向
        layout.scrollDirection = .vertical
        // 設定邊界
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isHidden = true // 一開始還沒抓到資料時不顯示
        cv.alpha = 0
        cv.register(RMCharacterEpisodeCollectionViewCell.self,
                    forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        cv.register(RMFooterLoadingCollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return cv
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchEpisodes()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubviews(collectionView, spinner)
        spinner.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension RMEpisodeListView: RMEpisodeListViewViewModelDelegate {
    func didLoadMoreEpisodes(with newIndexPath: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPath)
        }
    }
    func didSelectEpisode(_ episode: RMEpisode) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode)
    }
    
    func didLoadInitialEpisodes() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
