//
//  MainViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import UIKit
class MainViewController: BaseViewController<MainViewModel> {
    private var mainComponent: ItemCollectionView!
    let searchBar = UISearchBar()
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        addMainComponent()
        addViewModelListeners()
        viewModel.getData()
        configureUI()
    }
    func configureUI() {
        searchBar.sizeToFit()
        
        
        searchBar.showsScopeBar = false
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
        
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255,
                                                                   blue: 250/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = nil
        
        
    }
    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    private func addMainComponent() {
        mainComponent = ItemCollectionView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        mainComponent.delegate = viewModel
        view.addSubview(mainComponent)
        NSLayoutConstraint.activate([
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    private func addViewModelListeners() {
        viewModel.subscribeViewState { [weak self] state in
            switch state {
            case .loading:
                return
            case .done:
                self?.mainComponent.reloadCollectionView()
            default:
                break
            }
        }
        viewModel.subscribeDetailViewState { [weak self] data in
            self?.fireDetailView(with: data)
        }
    }
    private func fireDetailView(with data: ItemDetailViewRequest) {
        let viewController = ItemDetailViewBuilder.build(with: data)
        switch data.type {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        case .present:
            present(viewController, animated: true, completion: nil)
        }
    }
}
private var pendingRequestWorkItem: DispatchWorkItem?

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count>2 {
            pendingRequestWorkItem?.cancel()
            // Wrap our request in a work item
            let requestWorkItem = DispatchWorkItem { [weak self] in
                
                self?.viewModel.sendsearch(with: searchText)
                query = searchText
                self?.resultsLoader()
                searchBar.text = ""
            }
            // Save the new work item and execute it after 500 ms
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.500 ,execute: requestWorkItem)
            
        }
    }
    
    func resultsLoader(){
        //mainComponent.reloadCollectionView()
        //MainDataFormatter.reset()
        viewModel.getSearchData()
    }
    
    
    
}
