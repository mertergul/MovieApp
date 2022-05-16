//
//  BaseView.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addMajorViewComponents()
        setupViewConfigurations()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addMajorViewComponents()
        setupViewConfigurations()
    }
    
    func addMajorViewComponents() { }
    func setupViewConfigurations() { }
}
