//
//  RMTableLoadingFooterView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/5/3.
//

import UIKit

final class RMTableLoadingFooterView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spinner)
        spinner.startAnimating()
        addConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        spinner.snp.makeConstraints {
            $0.width.height.equalTo(55)
            $0.centerX.centerY.equalToSuperview()
        }
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        self.heightAnchor.constraint(equalToConstant: 100)
    }
    
}
