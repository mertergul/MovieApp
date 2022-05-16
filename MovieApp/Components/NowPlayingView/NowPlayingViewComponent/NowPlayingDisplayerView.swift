//
//  NowPlayingDisplayerView.swift
//  MovieApp
//
//  Created by Mert Ergul on 31.03.2022.
//

import Foundation
import UIKit


class NowPlayingDisplayerView: GenericBaseView<GenericDataProtocol> {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [ infoView,titleView])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 5
        return temp
    }()
    private lazy var imageContainer: CustomImageViewComponentContainer = {
        let temp = CustomImageViewComponentContainer()
        
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.contentMode = .scaleToFill
        temp.clipsToBounds = false
        return temp
    }()
    
    private lazy var infoView: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        temp.textColor = .white
        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 2
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.text = " "
        return temp
    }()
    private lazy var titleView: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font =  UIFont(name:"HelveticaNeue-Bold", size: 16)
        temp.textColor = .white
        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 2
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.text = " "
        return temp
    }()
    private lazy var dateView: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.boldSystemFont(ofSize: 16)
        temp.textColor = .systemGray
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .bottom
        temp.textAlignment = .right
        temp.text = " "
        return temp
    }()
    override func addMajorViewComponents() {
        super.addMajorViewComponents()
        addComponents()
    }
    
    private func addComponents() {
        addSubview(containerView)
        containerView.addSubview(imageContainer)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:  -35),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:  20),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:  -20),
            
        ])
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() as? NowPlayingDisplayerViewData else { return }
        imageContainer.setData(by: data.imageData)
        infoView.text = data.name
        titleView.text = data.title
       
        dateView.text = String(data.date)
    }
    
    
}


