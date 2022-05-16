//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import UIKit

class BaseViewController<V>: UIViewController {
    
    var viewModel: V!
    
    convenience init(viewModel: V) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewControllerConfigurations()
    }
    
    func prepareViewControllerConfigurations() {
        view.backgroundColor = .white
    }
    
}
