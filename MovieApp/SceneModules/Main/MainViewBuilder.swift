//
//  MainViewBuilder.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import Foundation
import UIKit

struct MainViewBuilder {
    static func build() -> UIViewController {
        let mainViewDataFormatter = MainDataFormatter()
        let viewModel = MainViewModel(dataFormatter: mainViewDataFormatter)
        let viewController = MainViewController(viewModel: viewModel)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.navigationBar.barTintColor = UIColor.white
        
        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        viewController.navigationController?.navigationBar.standardAppearance = appearance;
        return navigationViewController

    }
}

