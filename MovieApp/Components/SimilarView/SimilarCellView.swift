//
//  SimilarCellView.swift
//  MovieApp
//
//  Created by Mert Ergul on 17.04.2022.
//

import UIKit

class SimilarCellView: BaseCollectionViewCell {
    
    private lazy var similarDisplayer: SimilarDisplayerView = {
        let temp = SimilarDisplayerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViews() {
        super.addMajorViews()
        addContentDisplayer()
    }
    
    private func addContentDisplayer() {
        contentView.addSubview(similarDisplayer)
        
        NSLayoutConstraint.activate([
            similarDisplayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            similarDisplayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            similarDisplayer.topAnchor.constraint(equalTo: contentView.topAnchor),
            similarDisplayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setData(by value: GenericDataProtocol) {
        similarDisplayer.setData(by: value)
    }
}
