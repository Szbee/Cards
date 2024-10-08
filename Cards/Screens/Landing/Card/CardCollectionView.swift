//
//  CardCollectionView.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 27/09/2024.
//

import Foundation
import UIKit
import SnapKit

class CardCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    typealias ValueChanged = (Int) -> Void
    
    private lazy var collectionFlowLaout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLaout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = UIColor.secondaryBlue.withAlphaComponent(0.3)
        control.currentPageIndicatorTintColor = UIColor.secondaryBlue
        control.isUserInteractionEnabled = false
        
        return control
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView()
        
        return view
    }()
    
    var cards: [Int] = [] {
        didSet {
            pageControl.numberOfPages = cards.count
            setNeedsLayout()
            collectionView.reloadData()
        }
    }
    
    var selectedIndex = 0 {
        didSet {
            cardView.cardIndex = selectedIndex
        }
    }
    var indexChanged: ValueChanged?
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        
        cardView.cardIndex = selectedIndex
        
        addSubview(collectionView)
        addSubview(pageControl)
        
        pageControl.currentPage = selectedIndex
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func leftButtonTapped() {
        if selectedIndex > 0 {
            selectedIndex -= 1
        }
        
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = selectedIndex
        indexChanged?(selectedIndex)
    }
    
    func rightButtonTapped() {
        if selectedIndex < collectionView.numberOfItems(inSection: 0) - 1 {
            selectedIndex += 1
        }
        
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = selectedIndex
        indexChanged?(selectedIndex)
    }
    
    // MARK: - CollectionView functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell {
            cell.cardIndex = cards[indexPath.item]
            
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) {
            selectedIndex = visibleIndexPath.row
            pageControl.currentPage = selectedIndex
            
            indexChanged?(selectedIndex)
        }
    }
}
