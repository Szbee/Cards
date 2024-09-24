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
        view?.setViewState(.loading)
        interactor.fetchData{ [weak self] result in
            switch result {
            case .success(let response):
                self?.cardData = response
                self?.view?.reloadData()
                self?.view?.setViewState(.none)
            case .failure(let error):
                self?.view?.showErrorScreen(error: error.localizedDescription) {
                    self?.downloadData()
                }
            }
        }
    }
}

extension CardLandingPresenter: CardLandingPresenterInput {
    func loadData() {
        downloadData()
    }
}
