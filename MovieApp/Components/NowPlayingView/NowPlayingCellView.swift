//
//  NowPlayingCellView.swift
//  MovieApp
//
//  Created by Mert Ergul on 31.03.2022.
//

import UIKit

class NowPlayingCellView: BaseCollectionViewCell {
    
    private lazy var nowPlayingtDisplayer: NowPlayingDisplayerView = {
        let temp = NowPlayingDisplayerView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override func addMajorViews() {
        super.addMajorViews()
        addContentDisplayer()
    }
    
    private func addContentDisplayer() {
        contentView.addSubview(nowPlayingtDisplayer)
        
        NSLayoutConstraint.activate([
            nowPlayingtDisplayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nowPlayingtDisplayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nowPlayingtDisplayer.topAnchor.constraint(equalTo: contentView.topAnchor),
            nowPlayingtDisplayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setData(by value: GenericDataProtocol) {
        nowPlayingtDisplayer.setData(by: value)
    }
}
