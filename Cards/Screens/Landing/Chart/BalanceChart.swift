//
//  BalanceChart.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 05/10/2024.
//

import Foundation
import UIKit

class BalanceChart: UIView {
    
    var currentBalancePercent = 0.0
    var pendingBalancePercent = 0.0
    var availableBalancePercent = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let totalWidth = rect.width
        
        let currentBalanceWidth = totalWidth * currentBalancePercent
        let pendingBalanceWidth = totalWidth * pendingBalancePercent
        let availableBalanceWidth = totalWidth * availableBalancePercent
        
        context?.setFillColor(UIColor.appOrange.withAlphaComponent(0.6).cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: currentBalanceWidth, height: rect.height))
        
        context?.setFillColor(UIColor.lightOrange.cgColor)
        context?.fill(CGRect(x: currentBalanceWidth, y: 0, width: pendingBalanceWidth, height: rect.height))
        
        context?.setFillColor(UIColor.primaryBlue.cgColor)
        context?.fill(CGRect(x: currentBalanceWidth + pendingBalanceWidth, y: 0, width: availableBalanceWidth, height: rect.height))
    }
    
    func calculatePercent(currentBalance: Double, pendingBalance: Double, availableBalance: Double) {
        let totalBalance = currentBalance + pendingBalance + availableBalance
        currentBalancePercent = currentBalance / totalBalance
        pendingBalancePercent = pendingBalance / totalBalance
        availableBalancePercent = availableBalance / totalBalance
        
        setNeedsDisplay()
    }
}

