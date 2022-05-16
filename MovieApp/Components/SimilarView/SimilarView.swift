//
//  SimilarView.swift
//  MovieApp
//
//  Created by Mert Ergul on 17.04.2022.
//

import UIKit
class SimilarView: GenericBaseView<SimilarViewData> {
    weak var delegate: SimilarProviderProtocol?
    
   
    
    
    private lazy var componentCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        temp.register(SimilarCellView.self, forCellWithReuseIdentifier: SimilarCellView.identifier)
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
        return delegate?.isLoadingCellSimilar(for: indexPath.row) ?? false
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SimilarView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.askNumberOfItemSimilar(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isLoadingCell(for: indexPath) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCellView.identifier, for: indexPath) as? LoadingCellView else { fatalError() }
            return cell
        } else {
            guard let data = delegate?.askDataSimilar(at: indexPath.row) else { fatalError("Please provide at least one item!") }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCellView.identifier, for: indexPath) as? SimilarCellView else { fatalError("Please provide cell items") }
            cell.setData(by: data)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isLoadingCell(for: indexPath) {
            similarPageNumber += 1
            delegate?.getMoreDataSimilar()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = true
        self.delegate?.selectedItemSimilar(at: indexPath.row)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension SimilarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width / 3.2 , height: UIScreen.main.bounds.height / 5)
        
    }
}


