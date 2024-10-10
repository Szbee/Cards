//
//  BaseViewController.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 23/09/2024.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {

    enum ViewState {
        case loading
        case error
        case none
    }

    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var loadingView: LoadingView = {
        let view = LoadingView()
        
        return view
    }()
    
    lazy var errorView: ErrorView = {
        let view = ErrorView()
        
        return view
    }()
    
    var errorDescription: String?
    var tryAgainAction: ErrorView.ButtonAction?
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(contentView)
        view.addSubview(loadingView)
        view.addSubview(errorView)
        contentView.backgroundColor = .white
        
        setState(.none)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setState(_ state: ViewState, _ errorDescription: String? = nil, _ tryAgainAction: ErrorView.ButtonAction? = nil) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            contentView.isHidden = true
            errorView.isHidden = true
        case .error:
            errorView.isHidden = false
            contentView.isHidden = true
            loadingView.isHidden = true
            
            if let errorDescription, let tryAgainAction {
                errorView.errorDescription = errorDescription
                errorView.buttonAction = tryAgainAction
            }
        case .none:
            contentView.isHidden = false
            loadingView.isHidden = true
            errorView.isHidden = true
        }
    }
}
