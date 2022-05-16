//
//  MainViewController.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//
import UIKit

class MainViewController: BaseViewController<MainViewModel> {
    var searchController : UISearchController!
    private var mainComponentNowPlaying: NowPlayingView!
    private var mainComponentUpComing: ItemCollectionView!
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        addMainComponent()
        addViewModelListeners()
        DispatchQueue.main.async {self.viewModel.getUpComing()}
        DispatchQueue.main.async {self.viewModel.getNowPlaying()}
        
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search by username"
        searchBar.tintColor = UIColor.lightGray
        searchBar.barTintColor = UIColor.lightGray
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
    }
    
    private func addMainComponent() {
        mainComponentNowPlaying = NowPlayingView()
        mainComponentUpComing = ItemCollectionView()
        mainComponentNowPlaying.translatesAutoresizingMaskIntoConstraints = false
        mainComponentNowPlaying.delegate = viewModel
        mainComponentUpComing.translatesAutoresizingMaskIntoConstraints = false
        mainComponentUpComing.delegate = viewModel
        view.addSubview(mainComponentNowPlaying)
        view.addSubview(mainComponentUpComing)
        NSLayoutConstraint.activate([
            mainComponentNowPlaying.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponentNowPlaying.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponentNowPlaying.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainComponentNowPlaying.heightAnchor.constraint(equalToConstant: 350),
            
            mainComponentUpComing.topAnchor.constraint(equalTo: mainComponentNowPlaying.bottomAnchor, constant: 10),
            mainComponentUpComing.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 10),
            mainComponentUpComing.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponentUpComing.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func addViewModelListeners() {
        viewModel.subscribeViewState { [weak self] state in
            switch state {
            case .loading:
                return
            case .doneUpComing:
                self?.mainComponentUpComing.reloadCollectionView()
            case .doneNowPlaying:
                self?.mainComponentNowPlaying.reloadCollectionView()
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


extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("a")
        
//            self.present(UINavigationController(rootViewController: SearchViewController()), animated: false, completion: nil)
//        let viewController = SearchViewController()
//        viewController.modalPresentationStyle = .overCurrentContext
//        viewController.modalTransitionStyle = .crossDissolve
//        present(viewController, animated: true, completion: nil)
        }
}
//class SearchViewController: UIViewController {
//    let searchBar = UISearchBar()
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        view.backgroundColor =  UIColor.white
//        setUpNavBar()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        searchBar.becomeFirstResponder()
//    }
//    func setUpNavBar() {
//        searchBar.sizeToFit()
//        searchBar.searchBarStyle = .minimal
//        searchBar.placeholder = "Search by "
//        searchBar.tintColor = UIColor.lightGray
//        searchBar.barTintColor = UIColor.lightGray
//        navigationItem.titleView = searchBar
//        searchBar.isTranslucent = true
//    }
//}
