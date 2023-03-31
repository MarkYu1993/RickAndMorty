//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/30.
//

import UIKit

/// View for single character info
final class RMCharacterDetailView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(spinner, collectionView)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupportted")
    }
    
    private func setUpUI() {
        guard let collectionView = collectionView else { return }
        
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
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .photo:
            return createPhotoSectionLayout()
        case .information:
            return createInfoSectionLayout()
        case .episodes:
            return createEpisodeSectionLayout()
        }
    }
    
    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 10,
                                                        trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 10,
                                                        trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 10,
                                                        trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
