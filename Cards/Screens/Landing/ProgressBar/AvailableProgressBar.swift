//
//  AvailableProgressBar.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 08/10/2024.
//

import Foundation
import UIKit
import SnapKit

class AvailableProgressBar: UIView {
    private lazy var availableStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 0

        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .statusBlue
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .statusBlue
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .primaryBlue
        progressView.trackTintColor = .appOrange
        progressView.setProgress(0.0, animated: false)
        progressView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        return progressView
    }()
    
    private lazy var emptyImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "ic_alert")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .errorRed
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        
        view.isHidden = true
        
        return view
    }()
    
    private var progressValue: Double = 0.4
    private var totalAmount: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(availableStackView)
        availableStackView.addArrangedSubview(titleLabel)
        availableStackView.addArrangedSubview(amountLabel)
        addSubview(progressView)
        addSubview(emptyImageView)
        
        titleLabel.text = "Available"
        amountLabel.text = progressValue.formatNumber(minimumFractionDigits: 2)
        
        progressView.setProgress(Float(progressValue), animated: true)
    }
    
    private func setupConstraints() {
        availableStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        progressView.snp.makeConstraints { make in
            make.top.equalTo(availableStackView.snp.bottom).offset(16)
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(availableStackView.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
    
    func updateChart(totalAmount: Double, avaliableAmount: Double) {
        progressValue = avaliableAmount / totalAmount

        amountLabel.textColor = avaliableAmount == 0.0 ? .errorRed : .statusBlue
        emptyImageView.isHidden = avaliableAmount != 0.0
        amountLabel.text = avaliableAmount.formatNumber(minimumFractionDigits: 2)

        progressView.setProgress(Float(progressValue), animated: true)
    }
}
