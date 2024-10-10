//
//  CardDataTableViewCell.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 25/09/2024.
//

import UIKit
import SnapKit

class CardDataTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.statusBlue
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appGrey
        
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkBlue
        label.textAlignment = .right
        
        return label
    }()
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var currencyText: String? {
        didSet {
            currencyLabel.text = currencyText
        }
    }
    
    var dataText: String? {
        didSet {
            dataLabel.text = dataText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(currencyLabel)
        addSubview(dataLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(192)
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(titleLabel.snp.trailing)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
