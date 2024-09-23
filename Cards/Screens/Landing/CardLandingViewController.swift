//
//  CardLandingViewController.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation
import UIKit
import SnapKit

protocol CardLandingViewControllerInput: AnyObject {
    func reloadData()
}

class CardLandingViewController: UIViewController {
    var presenter: CardLandingPresenterInput
    
    init(presenter: CardLandingPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.title = "Cards"
        
        presenter.loadData()
    }
}

extension CardLandingViewController: CardLandingViewControllerInput {
    func reloadData() {
        print(presenter.cardData)
    }
}
