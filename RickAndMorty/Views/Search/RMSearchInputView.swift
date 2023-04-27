//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/26.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView,
                           didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchInputView: UIView {
    
    weak var delegate: RMSearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        return sb
    }()
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func createOptionStackView() -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 6
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        return stackView
    }
    
    private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
        let stackView = createOptionStackView()
        for x in 0..<options.count {
            let option = options[x]
            let button = createButton(with: option, tag: x)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(
        with option: RMSearchInputViewViewModel.DynamicOption,
        tag: Int
    ) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(string: option.rawValue,
                               attributes: [
                                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                .foregroundColor: UIColor.label
                               ]),
            for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 6
        return button
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else {
            return
        }
        let tag = sender.tag
        let selected = options[tag]
        delegate?.rmSearchInputView(self,
                                    didSelectOption: selected)
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
  
}
