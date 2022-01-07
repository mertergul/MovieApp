//
//  ItemDetailViewModel.swift
//  iTunes Search
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation


typealias ItemDetailDataBlock = (ItemDetailViewData) -> Void
typealias ItemDetailViewState = ((ViewState) -> Void)?

class ItemDetailViewModel {
    
   
    private let formatter: ItemDetailDataFormatterProtocol
    private let data: ItemDetailViewRequest
    private var dataState: ItemDetailDataBlock?
    init(data: ItemDetailViewRequest,
         formatter: ItemDetailDataFormatterProtocol) {
        self.data = data
        self.formatter = formatter
    }
    func getData() {
        formatter.detailDatas(response: { [weak self](responce) in
            self?.apiCallHandler(from: responce)
        })
    }
    func getDatal() {

        formatter.detailDatasSmilar(response: { [weak self](responce) in
            self?.apiCallHandler1(from: responce)
        })
    }
    func subscribeViewState(with completion: @escaping ItemDetailDataBlock) {
        dataState = completion
    }

    private func apiCallHandler(from response: MovieDetailModel) {
        let data = response
        dataState?(formatter.convertItemDetailView(from: data))
    }
    private func apiCallHandler1(from response: SimilarMoviesModel) {
        let data = response
        formatter.setData(with: data)
    }
}

extension ItemDetailViewModel: ItemProviderProtocol {
    func askNumberOfSection() -> Int {
        return 0
    }
    func sendsearch(with Value: String) {
    }
    func askNumberOfItem(in section: Int) -> Int {
        return 0
    }

    func askData(at index: Int) -> GenericDataProtocol? {
        return formatter.getItem(at: index)
    }
    func isLoadingCell(for index: Int) -> Bool {
        return index >= formatter.getCount()
    }
    func getMoreData() {
        getData()
    }
  
}
