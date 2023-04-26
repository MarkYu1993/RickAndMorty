//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {
    
    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewViewModel()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locations"
        view.backgroundColor = .systemBackground
        primaryView.delegate = self
        view.addSubview(primaryView)
        addConstraints()
        addSearchButton()
        viewModel.fetchLocations()
        viewModel.delegate = self
    }
    
    private func addConstraints() {
        primaryView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .search,
                        target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }

}

// MARK: - LocationViewModel Delegate

extension RMLocationViewController: RMLocationViewViewModelDelegate {
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}


// MARK: - RMLocationViewDelegate

extension RMLocationViewController: RMLocationViewDelegate {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
