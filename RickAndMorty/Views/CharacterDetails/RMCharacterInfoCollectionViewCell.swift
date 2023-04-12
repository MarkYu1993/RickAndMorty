//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/12.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.text = "Earth"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "globe.americas")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let titleContainerView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .secondarySystemBackground
        return vw
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLabel, iconImageView)
        titleContainerView.addSubview(titleLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        titleContainerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.33)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(36)
            $0.height.equalTo(30)
        }
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        valueLabel.text = nil
//        titleLabel.text = nil
//        iconImageView.image = nil
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        
    }
}
