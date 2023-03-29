//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/28.
//

import UIKit

/// Conrtoller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        view.backgroundColor = .systemBackground
        
        let request = RMRequest(endpoint: .character, pathComponents: ["2"], queryParameters: [URLQueryItem(name: "name", value: "rick"), URLQueryItem(name: "status", value: "alive")])
        print(request.url)
        
        RMService.shared.execute(request, expecting: String.self) { result in

        }
    }
}
