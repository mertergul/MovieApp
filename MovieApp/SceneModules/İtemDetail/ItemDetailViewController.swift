//
//  MainViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import UIKit



class ItemDetailViewController: BaseViewController<ItemDetailViewModel> {

    private var mainComponent: ItemDetailView!
    private var detailScrollView = UIScrollView()
    private var similarComponent: SimilarView!
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        addMainComponent()
        detailScrollView.minimumZoomScale = 1.0
        detailScrollView.maximumZoomScale = 4.0
        detailScrollView.zoomScale = 1.0
        detailScrollView.isUserInteractionEnabled = true
//                pageScroll.delegate = self //Here
        viewModelListeners()
        
        DispatchQueue.main.async {self.viewModel.similarGetData()}
        DispatchQueue.main.async {self.viewModel.getData()}
    }
    
    private func addMainComponent() {
        mainComponent = ItemDetailView()
        similarComponent = SimilarView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        detailScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        similarComponent.translatesAutoresizingMaskIntoConstraints = false
        similarComponent.delegate = viewModel
        
        detailScrollView.isScrollEnabled = true
        view.addSubview(detailScrollView)
        detailScrollView.addSubview(mainComponent)
        detailScrollView.addSubview(similarComponent)
        
        NSLayoutConstraint.activate([
            detailScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            detailScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            similarComponent.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor),
            similarComponent.heightAnchor.constraint(equalToConstant: 200),
            similarComponent.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor),
            
            mainComponent.centerXAnchor.constraint(equalTo: detailScrollView.centerXAnchor),
            mainComponent.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor),
            mainComponent.topAnchor.constraint(equalTo: detailScrollView.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor,constant: -200) ,

        ])
    }
    private func viewModelListeners() {

        viewModel.subscribeViewState { [weak self] state in


            switch state{
            case .loading:
                return
            case .detailcolletionview:
                self?.similarComponent.reloadCollectionView()
            }
        }

        viewModel.subscribeViewStateDetailView { [weak self ] data in
            self?.mainComponent.setData(by: data)
        }

    }
    
    
}

