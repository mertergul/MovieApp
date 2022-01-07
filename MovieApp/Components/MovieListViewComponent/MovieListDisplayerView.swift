//
//  MovieListDisplayerView.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation
import UIKit


class ContentDisplayerView: GenericBaseView<GenericDataProtocol> {
    
    private lazy var shadowContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.3
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [ infoView,titleView,priceView])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 5
        return temp
    }()
    private lazy var mainStackView1: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [ imageContainer,mainStackView,detailImage])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .center
        temp.distribution = .fill
        temp.axis = .horizontal
        temp.spacing = 10
        return temp
    }()
    
    private lazy var imageContainer: CustomImageViewComponentContainer = {
        let temp = CustomImageViewComponentContainer()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.heightAnchor.constraint(equalToConstant: 120).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 120).isActive = true
        temp.layer.cornerRadius = 0
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOffset = CGSize(width: 0, height: 0)
       temp.layer.shadowRadius = 0
       temp.layer.shadowOpacity = 0.6
        return temp
    }()
    private lazy var detailImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(imageLiteralResourceName: "detailView.png")
        temp.contentMode = .center
        return temp
    }()
    
    private lazy var infoView: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.boldSystemFont(ofSize: 20)
        temp.textColor = .black
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.text = " "
        return temp
    }()
    private lazy var titleView: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 16)
        temp.textColor = .systemGray
        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 2
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.text = " "
        

        return temp
    }()
    private lazy var priceView: UILabel = {
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
        addSubview(shadowContainerView)
        shadowContainerView.addSubview(containerView)
        containerView.addSubview(mainStackView1)
        mainStackView1.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
        
            shadowContainerView.topAnchor.constraint(equalTo: topAnchor),
            shadowContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: shadowContainerView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: shadowContainerView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: shadowContainerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: shadowContainerView.trailingAnchor),
            
            
            mainStackView1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            mainStackView1.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            mainStackView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            mainStackView1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        
        ])
    }

    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() as? MovieListDisplayerView else { return }
        imageContainer.setData(by: data.imageData)
        infoView.text = data.name
        titleView.text = data.title
        infoView.isHidden = data.isInfoViewHidden
        priceView.text = String(data.price)
    }

    
}

