//
//  ItemCollectionView.swift
//  MovieApp
//
//  Created by Mert Ergul on 15.11.2021.
//

import UIKit
class ItemCollectionView: GenericBaseView<ItemCollectionViewData> {
    weak var delegate: ItemProviderProtocol?
    private lazy var componentCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        temp.register(ItemCollectionCellView.self, forCellWithReuseIdentifier: ItemCollectionCellView.identifier)
        temp.register(LoadingCellView.self, forCellWithReuseIdentifier: LoadingCellView.identifier)
        return temp
    }()
    override func setupViewConfigurations() {
        super.setupViewConfigurations()
    }
    override func addMajorViewComponents() {
        super.addMajorViewComponents()
        addCollectionView()
    }
    private func addCollectionView() {
        addSubview(componentCollection)
        NSLayoutConstraint.activate([
            componentCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            componentCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            componentCollection.topAnchor.constraint(equalTo: topAnchor),
            componentCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.componentCollection.reloadData()
        }
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return delegate?.isLoadingCell(for: indexPath.row) ?? false
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ItemCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
   
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
                upComingPageNumber += 1
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
extension ItemCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (((UIScreen.main.bounds.width)))
        return CGSize(width: width, height: 150)
    }
  
}
