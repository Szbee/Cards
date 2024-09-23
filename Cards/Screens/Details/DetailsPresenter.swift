//
//  DetailsPresenter.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation

protocol DetailsPresenterInput: AnyObject {
}

class DetailsPresenter {    
    weak var view: DetailsViewControllerInput?
}

extension DetailsPresenter: DetailsPresenterInput {
}

