//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/25.
//

import UIKit

/// Interface to relay location view events
protocol RMLocationViewDelegate: AnyObject {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation)
}

final class RMLocationView: UIView {
    
    public weak var delegate: RMLocationViewDelegate?
    
    public var isLoadingMoreLocations = false
    
    private var viewModel: RMLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
            
            viewModel?.registerDidFinishPaginationBlock { [weak self] in
                DispatchQueue.main.async {
                    // Loading indicator 消失
                    self?.tableView.tableFooterView = nil
                    // Reload data
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private let tableView: UITableView = {
        let tbv = UITableView(frame: .zero, style: .grouped)
        tbv.alpha = 0
        tbv.isHidden = true
        tbv.register(RMLocationTableViewCell.self,
                     forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
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
        configureTable()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
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

// MARK: - UITableViewDelegate

extension RMLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        
        delegate?.rmLocationView(self,
                                 didSelect: locationModel)
    }
}

// MARK: - UITableViewDataSource

extension RMLocationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.cellIdentifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension RMLocationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel,
              !viewModel.cellViewModels.isEmpty,
              viewModel.shouldShowLoadMoreIndicator,
              !viewModel.isLoadingMoreLocations else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            /// scrollView往下移動的距離
            let offset = scrollView.contentOffset.y
            /// scrollView包含內容整體的高度(從頭捲到底加起來的高度)
            let totalContentHeight = scrollView.contentSize.height
            /// scrollView外表的高度
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            /// 這裡的120是底部view的高度(100)
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.showLoadingIndicator()
                viewModel.fetchAdditionalLocations()
            }
            t.invalidate()
        }
    }
    
    private func showLoadingIndicator() {
        let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        tableView.tableFooterView = footer
    }
}
