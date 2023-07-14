//
//  CustomTabBarController.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 02.07.2023.
//

import UIKit


final class CustomTabBarController: UITabBarController {
    private enum Constants {
        static let dictionary = UIImage(named: "Dictionary")
        static let training = UIImage(named: "Training")
        static let settings = UIImage(named: "SearchIcon")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureAppearance()
        
        selectedIndex = 0
    }
    
    // MARK: - Configurations
    private func configureTabBar() {
        let dictionaryController = createDictionaryNavigationController()
        let trainingController = createTrainingNavigationController()
        let settingsController = createSettingsNavigationController()
        
        viewControllers = [dictionaryController, trainingController, settingsController]
    }
    
    func configureAppearance() {
//        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        //        let width = tabBar.bounds.width - positionOnX * 2
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height + positionOnY * 3
        
        let roundedLayer = CAShapeLayer()
        let borderLayer = CAShapeLayer()
        
        let beziePath = UIBezierPath(roundedRect:
                CGRect(x: 0,
                        y: tabBar.bounds.minY,
                        width: width,
                        height: height
                        ),
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: height / 4, height: height / 4)
        )
        
        roundedLayer.path = beziePath.cgPath
        borderLayer.path = beziePath.cgPath
        
        tabBar.layer.insertSublayer(borderLayer, at: 0)
        tabBar.layer.insertSublayer(roundedLayer, at: 0)
//        tabBar.backgroundColor = .clear
        
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        tabBar.tintColor = UIColor(named: "PrimaryColor")
        tabBar.unselectedItemTintColor = UIColor(named: "InactiveTabBarItemColor")
        
        roundedLayer.fillColor = UIColor(named: "BackgroundColor")?.cgColor
        borderLayer.fillColor = UIColor(named: "PrimaryColor")?.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
    }
    
    func createDictionaryNavigationController() -> UIViewController {
        let view = MainDictionaryViewController()
        let presenter = MainDictionaryPresenter()
        presenter.view = view
        view.presenter = presenter
        
        let vc = configureViewController(
            view,
            title: "Dictionary",
            image: Constants.dictionary ?? .add
        )
        
        let dictionaryNavigationController = UINavigationController(rootViewController: vc)
//        dictionaryNavigationController.setNavigationBarHidden(true, animated: false)
        return dictionaryNavigationController
    }
    
    func createTrainingNavigationController() -> UIViewController {
        let vc = configureViewController(
            UIViewController(),
            title: "Training",
            image: Constants.training ?? .add
        )
        vc.view.backgroundColor = .white
        return vc
    }
    
    func createSettingsNavigationController() -> UIViewController {
        
        let mainSearchViewController = MainSearchViewController()
        
        let vc = configureViewController(
            mainSearchViewController,
            title: "Search",
            image: Constants.settings ?? .add
        )
        
        vc.view.backgroundColor = .white
        return vc
    }
    
    // MARK: Generates view controller for tab bar
    func configureViewController(
        _ viewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return viewController
    }
}


extension UIColor {
    static var white: UIColor {
        UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
