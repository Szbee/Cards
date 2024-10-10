//
//  Double+Extensions.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 06/10/2024.
//

import Foundation

extension Double {
    func formatNumber(minimumFractionDigits: Int, maximumFractionDigits: Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        numberFormatter.minimumFractionDigits = minimumFractionDigits
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        
        numberFormatter.groupingSeparator = "’"
        numberFormatter.decimalSeparator = "."
        
        return numberFormatter.string(for: self) ?? ""
    }
}
