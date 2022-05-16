//
//  NowPlayingView.swift
//  MovieApp
//
//  Created by Mert Ergul on 31.03.2022.
//

import UIKit
class NowPlayingView: GenericBaseView<NowPlayingViewData> {
    weak var delegate: NowPlayingProviderProtocol?
    
    private var pageControl = UIPageControl()
    
    
    private lazy var componentCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isPagingEnabled = true
        temp.showsHorizontalScrollIndicator = false
        temp.delegate = self
        temp.dataSource = self
        temp.register(NowPlayingCellView.self, forCellWithReuseIdentifier: NowPlayingCellView.identifier)
        temp.register(LoadingCellView.self, forCellWithReuseIdentifier: LoadingCellView.identifier)
        return temp
    }()
    override func setupViewConfigurations() {
        super.setupViewConfigurations()
    }
    override func addMajorViewComponents() {
        pageControl.numberOfPages = 20
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        super.addMajorViewComponents()
        addCollectionView()
    }
    private func addCollectionView() {
        addSubview(componentCollection)
        addSubview(pageControl)
        NSLayoutConstraint.activate([
            componentCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            componentCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            componentCollection.topAnchor.constraint(equalTo: topAnchor),
            componentCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: componentCollection.bottomAnchor, constant: -10),
            
        ])
    }
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.componentCollection.reloadData()
        }
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return delegate?.isLoadingCellNowPlaying(for: indexPath.row) ?? false
    }
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension NowPlayingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.askNumberOfItemNowPlaying(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isLoadingCell(for: indexPath) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCellView.identifier, for: indexPath) as? LoadingCellView else { fatalError() }
            return cell
        } else {
            guard let data = delegate?.askDataNowPlaying(at: indexPath.row) else { fatalError("Please provide at least one item!") }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCellView.identifier, for: indexPath) as? NowPlayingCellView else { fatalError("Please provide cell items") }
            cell.setData(by: data)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
       
        if isLoadingCell(for: indexPath) {
            NowPlayingPageNumber += 1
            delegate?.getMoreDataNowPlaying()
            self.pageControl.numberOfPages += 20
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isUserInteractionEnabled = true
        self.delegate?.selectedItemNowPlaying(at: indexPath.row)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension NowPlayingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 350)
    }
}

