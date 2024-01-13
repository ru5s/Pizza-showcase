//
//  Tabbar.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import UIKit

class Tabbar: UITabBarController {
    let firstPage = MainViewController()
    
    var navigationColor = UIColor.white
    var tintColor = UIColor.gray
    var tabBarActiveColor = UIColor.red
    var tabBarPassiveColor = UIColor(named: "TabBarPassive")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = tabBarActiveColor
        tabBar.unselectedItemTintColor = tabBarPassiveColor
        tabBar.backgroundColor = navigationColor
        
        setupVCs()
    }
    
    func setupVCs(){
        viewControllers = [
            createNavController(for: firstPage, title: "Меню", image: UIImage(named: "Group")!),
            createNavController(for: UIViewController(), title: "Контакты", image: UIImage(named: "Contacts")!),
            createNavController(for: UIViewController(), title: "Профиль", image: UIImage(named: "Union")!),
            createNavController(for: UIViewController(), title: "Корзина", image: UIImage(named: "Cart")!),
        ]
        
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                      title: String,
                                                      image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationController?.hidesBarsOnSwipe = true
        
        navController.navigationBar.titleTextAttributes = [.foregroundColor: tintColor as Any]
        navController.navigationBar.isTranslucent = true
        
        navController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(backBtn))
        
        rootViewController.navigationItem.title = title
        return navController
    }
    
    @objc private func backBtn(){
        dismiss(animated: true)
    }
    
}
