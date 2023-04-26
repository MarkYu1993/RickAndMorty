//
//  RMLocationDetailViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/26.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {
    private let viewModel: RMLocationDetailViewViewModel
    
    private let detailView = RMLocationDetailView()
    
    // MARK: - Init
    
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        setUpUI()
        detailView.delegate = self
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .action,
                        target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    private func setUpUI() {
        view.addSubview(detailView)
        detailView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func didTapShare() {
        
    }
}

// MARK: - ViewModel Delegate

extension RMLocationDetailViewController: RMLocationDetailViewViewModelDelegate {
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}

// MARK: - ViewDelegate

extension RMLocationDetailViewController: RMLocationDetailViewDelegate {
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
