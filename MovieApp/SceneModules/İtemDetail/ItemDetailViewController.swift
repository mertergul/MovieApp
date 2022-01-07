//
//  MainViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//

import UIKit
class ItemDetailViewController: BaseViewController<ItemDetailViewModel> {
    weak var delegate: ItemProviderProtocol?
    private var mainComponent: ItemDetailView!
    
    private lazy var similarDetailView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        temp.register(ItemDetailViewDataCell.self, forCellWithReuseIdentifier: ItemDetailViewDataCell.identifier)
        temp.register(LoadingCellView.self, forCellWithReuseIdentifier: LoadingCellView.identifier)
        return temp
    }()
    
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        view.backgroundColor = .white
        
        addMainComponent()
        viewModelListeners()
        viewModel.getDatal()
        viewModel.getData()
        
        
    }
    
    private func addMainComponent() {
        mainComponent = ItemDetailView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(mainComponent)
        mainComponent.addSubview(similarDetailView)
        
        NSLayoutConstraint.activate([
        
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainComponent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            similarDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            similarDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            similarDetailView.topAnchor.constraint(equalTo: mainComponent.bottomAnchor),
            similarDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.similarDetailView.reloadData()
        }
    }
    
    private func viewModelListeners() {
        viewModel.subscribeViewState { [weak self] data in
            self?.mainComponent.setData(by: data)
            
            self?.reloadCollectionView()
        }
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return delegate?.isLoadingCell(for: indexPath.row) ?? false
    }
    
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.askNumberOfItem(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if isLoadingCell(for: indexPath) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCellView.identifier, for: indexPath) as? LoadingCellView else { fatalError() }
            return cell
        } else {
            guard let data = delegate?.askData(at: indexPath.row) else { fatalError("Please provide at least one item!") }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionCellView.identifier, for: indexPath) as? ItemCollectionCellView else { fatalError("Please provide cell items") }
            cell.setData(by: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoadingCell(for: indexPath) {
                pageNumber += 1



            delegate?.getMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = true
        self.delegate?.selectedItem(at: indexPath.row)
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (((UIScreen.main.bounds.width)))
        return CGSize(width: width, height: 150)
        
    }
    
}
