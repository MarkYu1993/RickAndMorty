//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/26.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let vw = UIImageView()
        vw.contentMode = .scaleAspectFit
        vw.tintColor = .systemBlue
        return vw
    }()
    
    private let label: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 20, weight: .medium)
        return lb
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        addSubviews(iconView, label)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        iconView.snp.makeConstraints {
            $0.width.height.equalTo(90)
            $0.top.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(iconView.snp.bottom).offset(10)
        }
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
    
    
}
