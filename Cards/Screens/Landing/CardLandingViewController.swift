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

class CardLandingViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: CardLandingPresenterInput
    
    private lazy var cardContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkBlue")
        return view
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView()

        return view
    }()
    
    private lazy var dataTableView: UITableView = {
        let view = UITableView()
        view.allowsSelection = false

        return view
    }()
    
    private lazy var detailsButton: BorderedButton = {
        let button = BorderedButton()
        button.setTitle("Details", for: .normal)
        button.setTitle("Details", for: .highlighted)
        
        return button
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

        self.title = "Premium Card"
        
        presenter.loadData()
    }
    
    override func setupViews() {
        super.setupViews()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(CardDataTableViewCell.self, forCellReuseIdentifier: "CardDataTableViewCell")

        contentView.addSubview(cardContainerView)
        cardContainerView.addSubview(cardView)
        
        contentView.addSubview(dataTableView)
        contentView.addSubview(detailsButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        cardContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(148)
            make.leading.trailing.equalToSuperview()
        }
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        dataTableView.snp.makeConstraints { make in
            make.top.equalTo(cardContainerView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.greaterThanOrEqualTo(detailsButton.snp.top).offset(16)
        }
        
        detailsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(160)
            make.bottom.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Tableview Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardDataTableViewCell", for: indexPath) as? CardDataTableViewCell {
            cell.titleText = presenter.dataRows[indexPath.row].title
            cell.currencyText = presenter.dataRows[indexPath.row].currency
            cell.dataText = presenter.dataRows[indexPath.row].data
            
            return cell
        }
        
        return UITableViewCell()
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
        dataTableView.reloadData()
    }
}
