//
//  CardLandingPresenter.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation

protocol CardLandingPresenterInput: AnyObject {
    var dataRows: [CardLandingPresenter.LandingRowModel] { get set }
    var cardData: [CardResponse] { get set }
    var selectedIndex: Int { get }
    func loadData()
}

class CardLandingPresenter {
    
    struct LandingRowModel {
        var title: String
        var currency: String?
        var data: String
    }
    
    var interactor = CardInteractor()
    
    weak var view: CardLandingViewControllerInput?
    
    var cardData: [CardResponse] = []
    var dataRows: [LandingRowModel] = []
    
    var selectedIndex: Int = 0
    
    private func downloadData() {
        view?.setViewState(.loading)
        interactor.fetchData{ [weak self] result in
            switch result {
            case .success(let response):
                self?.cardData = response
                self?.dataRows = self?.setupRows() ?? []
                self?.view?.reloadData()
                self?.view?.setViewState(.none)
            case .failure(let error):
                self?.view?.showErrorScreen(error: error.localizedDescription) {
                    self?.downloadData()
                }
            }
        }
    }
    
    private func setupRows() -> [LandingRowModel] {
        [
            .init(
                title: "Current balance",
                currency: cardData[selectedIndex].currency,
                data: cardData[selectedIndex].currentBalance?.formatNumber(minimumFractionDigits: 2) ?? "0"
            ),
            .init(
                title: "Min. payment",
                currency: cardData[selectedIndex].currency,
                data: cardData[selectedIndex].minPayment?.formatNumber(minimumFractionDigits: 2) ?? "0"
            ),
            .init(
                title: "Due date",
                currency: nil,
                data: cardData[selectedIndex].dueDate?.formatDateString() ?? ""
            )
        ]
    }
}

extension CardLandingPresenter: CardLandingPresenterInput {

    func loadData() {
        downloadData()
    }
}
