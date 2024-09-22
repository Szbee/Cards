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
        
//        self.selectedIndex = 0
//        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .red
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .white
    }
    

    private func setupTabs() {
        let landing = self.createNavigation(with: "landing", and: UIImage(systemName: "house"), vc: CardLandingViewController())
        let details = self.createNavigation(with: "details", and: UIImage(systemName: "house"), vc: DetailsViewController())
        let statements = self.createNavigation(with: "statements", and: UIImage(systemName: "house"), vc: StatementsViewController())
        let more = self.createNavigation(with: "more", and: UIImage(systemName: "house"), vc: MoreViewController())

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
