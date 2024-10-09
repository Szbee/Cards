//
//  TabController.swift
//  Cards
//
//  Created by Hartmann Szabolcs on 22/09/2024.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
  
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .statusBlue
        self.tabBar.unselectedItemTintColor = .secondaryBlue
        self.tabBar.backgroundColor = .white
    }
    
    private func landingFactory() -> UIViewController {
        let presenter = CardLandingPresenter()
        let controller = CardLandingViewController(presenter: presenter)
        presenter.view = controller
        
        return controller
    }

    private func setupTabs() {
        let landing = self.createNavigation(with: "Cards", and: UIImage(named: "nav_cards")?.resized(to: CGSize(width: 24, height: 24)), vc: landingFactory())
        let details = self.createNavigation(with: "Transactions", and: UIImage(named: "nav_trans")?.resized(to: CGSize(width: 24, height: 24)), vc: TransactionsViewController())
        let statements = self.createNavigation(with: "Statements", and: UIImage(named: "nav_state")?.resized(to: CGSize(width: 24, height: 24)), vc: StatementsViewController())
        let more = self.createNavigation(with: "More", and: UIImage(named: "nav_more")?.resized(to: CGSize(width: 24, height: 24)), vc: MoreViewController())

        self.setViewControllers([landing, details, statements, more], animated: true)
    }
    
    private func createNavigation(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        
        let navigationController = UINavigationController(rootViewController: vc)
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance

        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        navigationController.viewControllers.first?.navigationItem.title = title + "Controller"
        
        return navigationController
    }

}
