//
//  CardView.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 24/09/2024.
//

import Foundation
import UIKit
import SnapKit

class CardView: UIView {
    private lazy var cardImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var cardShadow: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var cardIndex: Int? {
        didSet {
            setCardImage()
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
        addSubview(cardImageView)
        
        cardImageView.image = UIImage(named: "cccard")
    }
    
    private func setupConstraint() {
        cardImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCardImage() {
        guard let cardIndex else { return }
        
        if cardIndex == 1 {
            cardImageView.image = UIImage(named: "cccard")
        } else if cardIndex == 2 {
            cardImageView.image = UIImage(named: "cccard2")
        } else if cardIndex == 3 {
            cardImageView.image = UIImage(named: "cccard3")
        }
    }
}
