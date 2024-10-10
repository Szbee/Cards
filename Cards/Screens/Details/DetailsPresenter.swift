//
//  DetailsPresenter.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation

protocol DetailsPresenterInput: AnyObject {
    var cardData: CardResponse? { get set }
    var sections: [DetailsPresenter.Category] { get set }
    func loadData()
}

class DetailsPresenter { 
    struct Category {
        let name: String
        var rows: [CardLandingPresenter.LandingRowModel]
    }
    
    weak var view: DetailsViewControllerInput?
    
    var cardData: CardResponse?
    var sections: [Category] = []
    
    init(cardData: CardResponse?) {
        self.cardData = cardData

    }
    
    private func setupTableView() -> [DetailsPresenter.Category] {
        guard let cardData else { return [] }
        
        let balanceSection: [CardLandingPresenter.LandingRowModel] = [
            .init(
                title: "Balance carried over from last statement",
                currency: cardData.currency,
                data: cardData.balanceCarriedOverFromLastStatement?.formatNumber(minimumFractionDigits: 2) ?? "0"
            ),
            .init(
                title: "Total spendings since last statement",
                currency: cardData.currency,
                data: cardData.spendingsSinceLastStatement?.formatNumber(minimumFractionDigits: 2) ?? "0"
            ),
            .init(
                title: "Your latest re-payment",
                data: cardData.yourLastRepayment?.formatDateString() ?? ""
            )
        ]
        
        let accountDetailsSection: [CardLandingPresenter.LandingRowModel] = [
            .init(
                title: "Card account limit",
                currency: cardData.currency,
                data: cardData.accountDetails?.accountLimit?.formatNumber(minimumFractionDigits: 2) ?? "0"
            ),
            .init(
                title: "Card account number",
                data: cardData.accountDetails?.accountNumber ?? ""
            )
        ]
        
        let mainCardSection: [CardLandingPresenter.LandingRowModel] = [
            .init(
                title: "Card number",
                data: cardData.cardNumber ?? ""
            ),
            .init(
                title: "Card holder name",
                data: cardData.cardHolderName ?? ""
            )
        ]
        
        // Missing from API
        let supplementaryCardSection: [CardLandingPresenter.LandingRowModel] = [
            .init(
                title: "Card number",
                data: ""
            ),
            .init(
                title: "Card holder name",
                data: ""
            )
        ]
        
        return [
            .init(name: "Balance overview", rows: balanceSection),
            .init(name: "Account details", rows: accountDetailsSection),
            .init(name: "Main card", rows: mainCardSection)
//            .init(name: "Supplementary card", rows: supplementaryCardSection)
        ]
    }
    
}

extension DetailsPresenter: DetailsPresenterInput {
    func loadData() {
        guard let cardData else { return }
        
        sections = setupTableView()
        
        view?.setupReservationsRow(title: "Reservations/Pending (sum)", currency: cardData.currency ?? "", data: String(cardData.reservations ?? 0))
        view?.reloadData()
    }
}

