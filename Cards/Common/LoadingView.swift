//
//  LoadingView.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 23/09/2024.
//

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    private let spinner = UIActivityIndicatorView()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(spinner)
        
        spinner.startAnimating()
        spinner.style = .large
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        spinner.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
