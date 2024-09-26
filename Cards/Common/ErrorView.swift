//
//  ErrorView.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 23/09/2024.
//

import Foundation
import UIKit
import SnapKit

class ErrorView: UIView {
    typealias ButtonAction = () -> Void
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong"
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 72)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try Again", for: .normal)
        button.setTitle("Try Again", for: .highlighted)
        button.backgroundColor = .red
        
        return button
    }()
    
    var errorDescription: String? {
        didSet {
            descriptionLabel.text = errorDescription ?? ""
        }
    }
    var buttonAction: ButtonAction?
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(tryAgainButton)
        
        backgroundColor = .white
        tryAgainButton.addTarget(self, action: #selector(tryAgainAction), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(56)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tryAgainButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(160)
        }
    }
    
    @objc func tryAgainAction(sender: UIButton!) {
        buttonAction?()
    }
}

