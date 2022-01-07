//
//  MainViewModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//


import Foundation



class MainViewModel{
    
    private var mainViewState: ((ViewState) -> Void)?
    private var detailViewState: ItemDetailRequestBlock?
    

    private var dataFormatter: MainDataFormatterProtocol
    
    init(
         dataFormatter: MainDataFormatterProtocol) {
        self.dataFormatter = dataFormatter
    }
    public func getData() {
        mainViewState?(.loading)
        dataFormatter.fetchAllDatas(response: { [weak self](responce) in
            self?.apiCallHandler(from: responce)})
    }
    public func getSearchData() {
        mainViewState?(.loading)
        dataFormatter.searchDatas(response: { [weak self](responce) in
            self?.searchApiCallHandler(from: responce)})
    }
    
    func subscribeViewState(with completion: @escaping (ViewState) -> Void) {
        mainViewState = completion
    }
    func subscribeDetailViewState(with completion: @escaping ItemDetailRequestBlock) {
        detailViewState = completion
    }
    private func apiCallHandler(from response: MovieModel) {
        dataFormatter.setData(with: response)
        mainViewState?(.done)
    }
    private func searchApiCallHandler(from response: SearchModel) {
        dataFormatter.searchsetData(with: response)
        mainViewState?(.done)
    }
}
extension MainViewModel: ItemProviderProtocol {
    func askNumberOfSection() -> Int {
        return 0
    }
    func sendsearch(with Value: String) {
        dataFormatter.reset()
    }
    func askNumberOfItem(in section: Int) -> Int {
        return dataFormatter.getNumbeOfItem(in: section)
    }

    func askData(at index: Int) -> GenericDataProtocol? {
        return dataFormatter.getItem(at: index)
    }
    func isLoadingCell(for index: Int) -> Bool {
        return index >= dataFormatter.getCount()
    }
    func getMoreData() {
        getData()
    }
    func selectedItem(at index: Int) {
        print(index)
        detailViewState?(ItemDetailViewRequest(id: dataFormatter.getItemId(at: index), type: .push))
    }
}

