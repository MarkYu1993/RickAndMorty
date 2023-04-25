//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import StoreKit
import UIKit
import SwiftUI
import SafariServices

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Settings"
        addSwiftUIController()
    }
 
    private func addSwiftUIController() {
        let settingsSwiftUIController =
        UIHostingController(rootView: RMSettingsView(
            viewModel: RMSettingsViewViewModel(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    return RMSettingsCellViewModel(type: $0) { [weak self]option in
                        self?.handleTap(option: option)
                    }
                }))))
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        
        settingsSwiftUIController.view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            // Open Website
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            // show rating prompt
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
