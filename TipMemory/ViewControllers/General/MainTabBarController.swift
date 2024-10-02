//
//  MainTabBarController.swift
//  TipMemory
//
//  Created by 권정근 on 9/23/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let locationVC = UINavigationController(rootViewController: LocationViewController())
        
        
        homeVC.tabBarItem.image = UIImage(systemName: "house.circle")
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        homeVC.tabBarItem.title = "Home"
        
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        searchVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        searchVC.tabBarItem.title = "Search"
        
        locationVC.tabBarItem.image = UIImage(systemName: "map.circle")
        locationVC.tabBarItem.selectedImage = UIImage(systemName: "map.circle.fill")
        locationVC.tabBarItem.title = "Map"
        
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        profileVC.tabBarItem.selectedImage = UIImage(systemName: "person.circle.fill")
        profileVC.tabBarItem.title = "Profile"
        
        
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.backgroundColor = .secondarySystemBackground
       
        
        setViewControllers([homeVC, searchVC, locationVC, profileVC], animated: true)
    }
}
