//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/14.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {
    private let viewModel: RMEpisodeDetailViewViewModel
    
    private let detailView = RMEpisodeDetailView()
    
    // MARK: - Init
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        setUpUI()
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .action,
                        target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
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

// MARK: - Delegate

extension RMEpisodeDetailViewController: RMEpisodeDetailViewViewModelDelegate {
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
