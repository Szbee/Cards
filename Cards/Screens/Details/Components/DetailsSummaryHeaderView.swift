//
//  DetailsSummaryHeaderView.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 03/10/2024.
//

import Foundation
import UIKit
import SnapKit

class DetailsSummaryHeaderView: UIView {
    private lazy var balanceStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 0

        return view
    }()
    
    private lazy var avaliableStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 0

        return view
    }()
    
    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Current balance"
        label.textColor = UIColor.statusBlue
        
        return label
    }()
    
    private lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appOrange
        
        return label
    }()
    
    private lazy var availableTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Avaliable"
        label.textColor = UIColor.statusBlue
        
        return label
    }()
    
    private lazy var availableAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.statusBlue
        
        return label
    }()
    
    var balance: String = "0" {
        didSet {
            balanceAmountLabel.text = balance
        }
    }
    
    var available: String = "0" {
        didSet {
            availableAmountLabel.text = available
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceTitleLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        addSubview(avaliableStackView)
        avaliableStackView.addArrangedSubview(availableTitleLabel)
        avaliableStackView.addArrangedSubview(availableAmountLabel)
        
    }
    
    private func setupConstraint() {
        balanceStackView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        avaliableStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
