//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import UIKit

/// Conrtoller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setUpView()
    }
    
    private func setUpView() {
        characterListView.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(characterListView)
        characterListView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - RMCharacterListViewDelegate
extension RMCharacterViewController: RMCharacterListViewDelegate {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        // Open detail controller for that character
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
