//
//  ItemDetailView.swift
//  WeatherApplication
//
//  Created by Mert Ergul on 24.10.2021.
//

import UIKit

class ItemDetailView: GenericBaseView<GenericDataProtocol> {
 
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private lazy var imbdImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(imageLiteralResourceName: "imdbLogo.png")
        temp.contentMode = .center
        
        return temp
    }()
    private lazy var circleIcon: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(imageLiteralResourceName: "icon.png")
        temp.contentMode = .center
        
        return temp
    }()
    private lazy var starIcon: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = false
        temp.image = UIImage(imageLiteralResourceName: "rateIcon.png")
        temp.contentMode = .center
        return temp
    }()
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [labelStackView,infoView,destLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 20
        return temp
    }()
    private lazy var labelStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [imbdImage,starIcon,ratingLabel,circleIcon,deatilDate])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.alignment = .fill
        temp.axis = .horizontal
        temp.spacing = 10
        return temp
    }()
    private lazy var imageContainer: CustomImageViewComponentContainer = {
        let temp = CustomImageViewComponentContainer()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.cornerRadius = 2
        temp.contentMode = .scaleToFill
        temp.clipsToBounds = true
        return temp
    }()
    private lazy var infoView: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.boldSystemFont(ofSize: 20)
        temp.textColor = .black
        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 2
        temp.textAlignment = .left
        temp.text = " "
        return temp
    }()
    private lazy var destLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 14)
        temp.textColor = .black
        temp.lineBreakMode = .byWordWrapping
        temp.numberOfLines = 0
        temp.textAlignment = .left
        temp.text = " "
        return temp
    }()
    private lazy var ratingLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 16)
        temp.textColor = .black
//        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 0
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.text = " "
        return temp
    }()
    private lazy var constRatingLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 16)
        temp.textColor = .systemGray
        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 1
        temp.contentMode = .center
        temp.textAlignment = .left
        temp.text = "/10"
        return temp
    }()
    private lazy var deatilDate: UILabel = {
        let temp = UILabel()
        
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.systemFont(ofSize: 16)
        temp.textColor = .black
        temp.lineBreakMode = .byTruncatingTail
        temp.numberOfLines = 2
        temp.textAlignment = .justified
        temp.text = " "
        temp.widthAnchor.constraint(equalToConstant:240).isActive = true
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
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 300),
            imageContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 320),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -20),

        ])
    }
    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() as? ItemDetailViewData else { return }
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 1.0, options: .transitionCrossDissolve) {
                self.imageContainer.setData(by: data.imageData)
                self.infoView.text = data.infoView
                self.deatilDate.text = data.deatilDate
                self.ratingLabel.text = data.ratingLabel
                self.destLabel.text = data.destLabel
            }
        }
    }
    func activationManager(by value: Bool) {
        isHidden = !value
    }


 
    


}
