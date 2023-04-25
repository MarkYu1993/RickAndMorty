//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/25.
//

import UIKit

final class RMLocationView: UIView {
    
    private var viewModel: RMLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let tbv = UITableView()
        tbv.alpha = 0
        tbv.isHidden = true
        tbv.register(UITableViewCell.self,
                     forCellReuseIdentifier: "cell")
        return tbv
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView()
        spin.hidesWhenStopped = true
        return spin
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(tableView, spinner)
        spinner.startAnimating()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        spinner.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    public func configure(with viewModel: RMLocationViewViewModel) {
        self.viewModel = viewModel
    }
    
}
