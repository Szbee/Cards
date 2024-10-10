//
//  DetailsViewController.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import Foundation
import UIKit
import SnapKit

protocol DetailsViewControllerInput: AnyObject {
    func setupReservationsRow(title: String, currency: String, data: String)
    func reloadData()
}

class DetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var headerView: DetailsSummaryHeaderView = {
        let view = DetailsSummaryHeaderView()
        
        return view
    }()

    private lazy var chartView: BalanceChart = {
        let view = BalanceChart()
        
        return view
    }()
    
    private lazy var reservationsColorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightOrange
        return view
    }()
    
    private lazy var reservationsCell: CardDataTableViewCell = {
        let cell = CardDataTableViewCell()
        return cell
    }()
    
    private lazy var dataTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.allowsSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    var presenter: DetailsPresenterInput
    
    init(presenter: DetailsPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        
        presenter.loadData()
    }
    
    override func setupView() {
        super.setupView()

        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(CardDataTableViewCell.self, forCellReuseIdentifier: "CardDataTableViewCell")
        
        contentView.addSubview(headerView)
        contentView.addSubview(chartView)
        contentView.addSubview(reservationsColorView)
        contentView.addSubview(reservationsCell)
        contentView.addSubview(dataTableView)
        
        headerView.balance = presenter.cardData?.currentBalance?.formatNumber(minimumFractionDigits: 2) ?? "0"
        headerView.available = presenter.cardData?.availableBalance?.formatNumber(minimumFractionDigits: 2) ?? "0"
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        reservationsColorView.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
            make.width.equalTo(8)
            make.height.equalTo(reservationsCell.snp.height)
        }
        
        reservationsCell.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(24)
            make.leading.equalTo(reservationsColorView.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
        dataTableView.snp.makeConstraints { make in
            make.top.equalTo(reservationsCell.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().inset(16)
        }
    }
    
    private func animateChart(cardData: CardResponse?) {
        UIView.animate(withDuration: 1.0) {
            self.chartView.frame.size.width = self.view.frame.width - 40
        }
    }
    
    // MARK: - TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.sections[section].name.uppercased()
    }
      
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardDataTableViewCell", for: indexPath) as? CardDataTableViewCell {
            let row = presenter.sections[indexPath.section].rows
            
            cell.titleText = row[indexPath.row].title
            cell.currencyText = row[indexPath.row].currency
            cell.dataText = row[indexPath.row].data
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension DetailsViewController: DetailsViewControllerInput {
    func setupReservationsRow(title: String, currency: String, data: String) {
        reservationsCell.titleText = title
        reservationsCell.currencyText = currency
        reservationsCell.dataText = data
        guard let cardData = presenter.cardData else { return }
        
        chartView.calculatePercent(currentBalance: cardData.currentBalance ?? 0.0, pendingBalance: cardData.reservations ?? 0.0, availableBalance: cardData.availableBalance ?? 0.0)
        animateChart(cardData: presenter.cardData)
    }

    func reloadData() {
        dataTableView.reloadData()
    }
}

