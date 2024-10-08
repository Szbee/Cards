//
//  CardCollectionViewCell.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 27/09/2024.
//

import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    private lazy var cardView: CardView = {
        let view = CardView()

        return view
    }()

    var cardIndex: Int? {
        didSet {
            cardView.cardIndex = cardIndex
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(cardView)
    }
    
    private func setupConstraint() {
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
