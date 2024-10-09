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
    var cardImages: [Int] { get set }
    func setViewState(_ state: BaseViewController.ViewState)
    func showErrorScreen(error: String, buttonAction: @escaping ErrorView.ButtonAction)
    func reloadData()
}

class CardLandingViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: CardLandingPresenterInput
    
    private lazy var cardChooserView: CardSwitcherComponentView = {
        let view = CardSwitcherComponentView()
        
        return view
    }()
    
    private lazy var chartView: AvailableProgressBar = {
        let view = AvailableProgressBar()
        
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
    
    var cardImages: [Int] = []
    
    init(presenter: CardLandingPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cards"
        self.navigationItem.title = "Premium Card"
        
        presenter.loadData()
    }
    
    override func setupViews() {
        super.setupViews()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(CardDataTableViewCell.self, forCellReuseIdentifier: "CardDataTableViewCell")

        contentView.addSubview(cardChooserView)
        contentView.addSubview(chartView)
        contentView.addSubview(dataTableView)
        contentView.addSubview(detailsButton)
        
        cardChooserView.cardCollectionView.selectedIndex = presenter.selectedIndex
        cardChooserView.cardCollectionView.indexChanged = { [weak self] index in
            self?.presenter.selectedIndex = index
            self?.updateChart()
            self?.dataTableView.reloadData()
        }
        
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        cardChooserView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(cardChooserView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        dataTableView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(16)
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
    
    private func updateChart() {
        let chartCurrentBalance = presenter.cardData[presenter.selectedIndex].currentBalance ?? 0.0
        let chartAvailableBalance = presenter.cardData[presenter.selectedIndex].availableBalance ?? 0.0

        chartView.updateChart(totalAmount: chartCurrentBalance + chartAvailableBalance, avaliableAmount: chartAvailableBalance)
    }
    
    @objc func detailsButtonTapped() {
        let presenter = DetailsPresenter(cardData: presenter.cardData[presenter.selectedIndex])
        let view = DetailsViewController(presenter: presenter)
        presenter.view = view

        self.navigationController?.pushViewController(view, animated: true)
    }
    
    // MARK: - TableView Functions
    
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
        cardChooserView.cards = cardImages
        updateChart()
        dataTableView.reloadData()
    }
}
