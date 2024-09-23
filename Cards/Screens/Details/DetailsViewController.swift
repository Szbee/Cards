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
}

class DetailsViewController: UIViewController {
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
        view.backgroundColor = .darkGray
        self.title = "Details"
        
    }
}

extension DetailsViewController: DetailsViewControllerInput {
}

