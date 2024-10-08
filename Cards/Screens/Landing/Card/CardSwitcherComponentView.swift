//
//  CardSwitcherComponentView.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 06/10/2024.
//

import Foundation
import UIKit
import SnapKit

class CardSwitcherComponentView: UIView {
    let arrowImage = UIImage(named: "ic_arrowleft")?.withRenderingMode(.alwaysTemplate)
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(arrowImage, for: .normal)
        button.setImage(arrowImage, for: .highlighted)
        button.tintColor = UIColor.secondaryBlue

        return button
    }()
    
    lazy var cardCollectionView: CardCollectionView = {
        let view = CardCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(arrowImage, for: .normal)
        button.setImage(arrowImage, for: .highlighted)
        button.tintColor = UIColor.secondaryBlue
        button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        
        return button
    }()
    
    var cards: [Int] = [] {
        didSet {
            cardCollectionView.cards = cards
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(leftButton)
        addSubview(cardCollectionView)
        addSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
    }
    
    private func setupConstraint() {
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.width.height.equalTo(40)
        }
        
        cardCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(leftButton.snp.trailing)
            make.trailing.equalTo(rightButton.snp.leading)
        }
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(40)
        }
    }
    
    @objc func leftAction(sender: UIButton!) {
        cardCollectionView.leftButtonTapped()
    }
    
    @objc func rightAction(sender: UIButton!) {
        cardCollectionView.rightButtonTapped()
    }
}
