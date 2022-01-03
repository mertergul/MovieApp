//
//  SplashViewBuilder.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import UIKit

class SplashViewBuilder {
    
    class func build(with completion: @escaping VoidBlock) -> UIViewController {
        let viewModel = SplashViewModel(completion: completion)
        return SplashViewController(viewModel: viewModel)
    }
    
}
