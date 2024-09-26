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
        
        return view
    }()
    
    private lazy var cardShadowView: UIImageView = { // asettbe nincs shadow amit le lehetne tölteni
        let view = UIImageView()
        
        return view
    }()
    
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
            make.width.equalTo(202)
            make.height.equalTo(126)
        }
    }
}
