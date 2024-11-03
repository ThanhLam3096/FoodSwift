//
//  FoodTabBarViewController.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 4/10/24.
//

import UIKit

class FoodTabBarViewController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Private Function
    private func setupUI() {
        let homeVC = HomeViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home_tabbar"), tag: 0)
        
        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search_tabbar"), tag: 1)

        let ordersVC = OrdersViewController()
        let ordersNavi = UINavigationController(rootViewController: ordersVC)
        ordersVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(named: "order-tabbar"), tag: 2)
        
        let profileVC = ProfileViewController()
        let profileNavi = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tabbar"), tag: 3)

        self.viewControllers = [homeNavi, searchNavi, ordersNavi, profileNavi]
        self.selectedIndex = 0
//        self.tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.tabBar.tintColor = Color.activeColor
//        self.tabBar.barTintColor = #colorLiteral(red: 0.9921568627, green: 0.8117648363, blue: 0.1843136251, alpha: 1)
        self.tabBar.unselectedItemTintColor = Color.tabBarColor
        
        let unselectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fontYugothicLight(ofSize: 12) as Any,
            .foregroundColor: Color.tabBarColor
        ]
        
        // Tùy chỉnh font chữ và kích thước cho tab đã được chọn (selected)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.fontYugothicLight(ofSize: 12) as Any,
            .foregroundColor: Color.activeColor
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
