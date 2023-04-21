//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import UIKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    private let viewModel = RMSettingsViewViewModel(
        cellViewModels: RMSettingsOption.allCases.compactMap({
        return RMSettingsCellViewModel(type: $0)
    }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Settings"
    }
 
}
