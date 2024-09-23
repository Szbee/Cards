//
//  CardModel.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation

struct CardResponse: Decodable {
    let cardId: String?
    let issuer: String?
    let cardNumber: String?
    let expirationDate: String?
    let cardHolderName: String?
    let friendlyName: String?
    let currency: String?
    let cvv: String?
    let availableBalance: Int?
    let currentBalance: Int?
    let minPayment: Int?
    let dueDate: String?
    let reservations: Int?
    let balanceCarriedOverFromLastStatement: Int?
    let spendingsSinceLastStatement: Int?
    let yourLastRepayment: String?
    let accountDetails: AccountDetails?
    let status: String?
    let cardImage: String?
}

struct AccountDetails: Decodable {
    let accountLimit: Int?
    let accountNumber: String?
}
