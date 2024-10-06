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
    let availableBalance: Double?
    let currentBalance: Double?
    let minPayment: Double?
    let dueDate: String?
    let reservations: Double?
    let balanceCarriedOverFromLastStatement: Double?
    let spendingsSinceLastStatement: Double?
    let yourLastRepayment: String?
    let accountDetails: AccountDetails?
    let status: String?
    let cardImage: String?
}

struct AccountDetails: Decodable {
    let accountLimit: Double?
    let accountNumber: String?
}
