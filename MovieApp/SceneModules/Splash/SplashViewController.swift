//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import Foundation
import UIKit

class SplashViewController: BaseViewController<SplashViewModel> {
    
    private lazy var image: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(imageLiteralResourceName: "splashlogo.svg")
        temp.contentMode = .center
        return temp
    }()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        appendComponents()
        viewModel.fireApplicationInitiateProcess()
        view.backgroundColor = UIColor(red: 13.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 1)
    }
    private func appendComponents() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
