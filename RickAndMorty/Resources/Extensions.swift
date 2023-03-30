//
//  Extensions.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/3/29.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
        })
    }
}
