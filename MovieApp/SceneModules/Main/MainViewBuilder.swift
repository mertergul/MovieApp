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
        
       
        return MainViewController(viewModel: MainViewModel())
    }
}

