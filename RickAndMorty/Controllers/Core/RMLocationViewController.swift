//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Locations"
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .search,
                        target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }

}
