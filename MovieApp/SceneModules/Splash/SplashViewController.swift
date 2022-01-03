//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import Foundation
import UIKit

class SplashViewController: BaseViewController<SplashViewModel> {
//    splash view compenent
    
    private lazy var image: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(imageLiteralResourceName: "splashscreen.png")
        temp.contentMode = .center
        return temp
    }()
    
    private lazy var titleInfo: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.text = "Movie App"
        temp.font = UIFont.systemFont(ofSize: 34 ,weight: UIFont.Weight.bold)
        temp.textColor = .black
        return temp
    }()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        appendComponents()
        viewModel.fireApplicationInitiateProcess()
        view.backgroundColor = UIColor(red: 245.0/255.0, green: 195.0/255.0, blue: 68.0/255.0, alpha: 1)
        
    }
    
    private func appendComponents() {
        view.addSubview(image)
        view.addSubview(titleInfo)
        
        NSLayoutConstraint.activate([
        
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200)
            
            
        ])
    }
    
}
