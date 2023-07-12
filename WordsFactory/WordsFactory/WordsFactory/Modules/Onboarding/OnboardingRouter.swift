//
//  OnboardingRouter.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 16.07.2023.
//

import Foundation
import UIKit

class OnboardingRouter {
    var navigationContr: UINavigationController = .init(rootViewController: CustomTabBarController())
    
    init() {
        navigationContr.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        if !UserDefaults.standard.bool(forKey: "isOldUser") {
            let onboarding = OnboardingViewController()
            onboarding.onExit = {
                UserDefaults.standard.setValue(true, forKey: "isOldUser")
                self.navigationContr.popViewController(animated: true)
            }
            navigationContr.pushViewController(onboarding, animated: true)
        }
    }
}
