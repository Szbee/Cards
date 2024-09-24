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
    func setViewState(_ state: BaseViewController.ViewState)
    func showErrorScreen(error: String, buttonAction: @escaping ErrorView.ButtonAction)
    func reloadData()
}

class CardLandingViewController: BaseViewController {
    var presenter: CardLandingPresenterInput
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello"

        return label
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    init(presenter: CardLandingPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .green
        self.title = "Cards"
        
        presenter.loadData()
    }
    
    override func setupViews() {
        super.setupViews()

        contentView.addSubview(cardView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(148)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
}

extension CardLandingViewController: CardLandingViewControllerInput {
    func setViewState(_ state: ViewState) {
        setState(state)
    }
    
    func showErrorScreen(error: String, buttonAction: @escaping ErrorView.ButtonAction) {
        setState(.error, error, buttonAction)
    }
    
    func reloadData() {
        print(presenter.cardData)
    }
}
