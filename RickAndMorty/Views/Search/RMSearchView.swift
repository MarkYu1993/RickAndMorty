//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/26.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView,
                      didSelectOption: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewDelegate?
    
    let viewModel: RMSearchViewViewModel
    
    // MARK: - Subviews
    
    // SearchInputView(bar, selection buttons)
    
    private let searchInputView = RMSearchInputView()
    
    private let noResultsView = RMNoSearchResultsView()
    
    // No results view
    
    // Results collectionView
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(noResultsView, searchInputView)
        addConstraints()
        
        searchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        // Search input view
        searchInputView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(viewModel.config.type == .episode ? 55 : 110)
        }
        
        // No results
        noResultsView.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
    
}

// MARK: - CollectionView

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - RMSearchInputViewDelegate

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self,
                               didSelectOption: option)
    }
}
