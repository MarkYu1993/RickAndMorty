//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/18.
//

import UIKit

final class RMEpisodeDetailView: UIView {
    
    private var viewModel: RMEpisodeDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        addSubviews(collectionView, spinner)
        self.collectionView = collectionView
        setUpUI()
        
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setUpUI() {
        guard let collectionView = collectionView else {
            return
        }
        spinner.snp.makeConstraints {
            $0.height.width.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let cv = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self,
                    forCellWithReuseIdentifier: "cell")
        cv.isHidden = true
        cv.alpha = 0
        return cv
        
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
        self.viewModel = viewModel
    }
    
}

extension RMEpisodeDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension RMEpisodeDetailView {
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem (
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 10,
                                                     bottom: 10,
                                                     trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(100)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
