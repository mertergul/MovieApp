//
//  ItemDetailViewCell.swift
//  MovieApp
//
//  Created by Mert Ergul on 6.01.2022.
//

import UIKit

class ItemDetailViewDataCell: BaseCollectionViewCell {
    
    private lazy var contentDisplayer: SimilarListViewComponentView = {
        let temp = SimilarListViewComponentView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViews() {
        super.addMajorViews()
        addContentDisplayer()
    }
    
    private func addContentDisplayer() {
        contentView.addSubview(contentDisplayer)
        
        NSLayoutConstraint.activate([
        
            contentDisplayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentDisplayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentDisplayer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentDisplayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        ])
        
    }
    
    func setData(by value: GenericDataProtocol) {
        contentDisplayer.setData(by: value)
    }
}
