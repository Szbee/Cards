//
//  String+Extensions.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 06/10/2024.
//

import Foundation

extension String {
    func formatDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: self) else { return nil }

        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: date)
    }
}
