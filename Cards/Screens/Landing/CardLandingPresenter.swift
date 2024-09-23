//
//  CardLandingPresenter.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation

protocol CardLandingPresenterInput: AnyObject {
    var cardData: [CardResponse] { get set }
    func loadData()
}

class CardLandingPresenter {
    var interactor = CardInteractor()
    
    weak var view: CardLandingViewControllerInput?
    
    var cardData: [CardResponse] = []
    
    private func downloadData() {
        interactor.fetchData{ [weak self] result in
            switch result {
            case .success(let response):
                self?.cardData = response
                self?.view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CardLandingPresenter: CardLandingPresenterInput {
    func loadData() {
        downloadData()
    }
}
