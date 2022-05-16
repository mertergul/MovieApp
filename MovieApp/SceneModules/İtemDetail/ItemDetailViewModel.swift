//
//  ItemDetailViewModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation


typealias ItemDetailDataBlock = (ItemDetailViewData) -> Void


class ItemDetailViewModel {

   
    private var detailViewState: ItemDetailRequestBlock?
    private var formatter: ItemDetailDataFormatterProtocol
    private let data: ItemDetailViewRequest
    private var dataState: ((DetailViewStatee) -> Void)?
    private var dataState1: ItemDetailDataBlock?
    
    init(data: ItemDetailViewRequest,
         formatter: ItemDetailDataFormatterProtocol) {
        self.data = data
        self.formatter = formatter
    }
    func getData() {
//        similarState?(.loading)
        formatter.detailDatas(response: { [weak self](responce) in
            self?.apiCallHandler(from: responce)

        })
    }
    func similarGetData(){
       
        formatter.fetcSimilar(response: {[weak self](responce) in
            self?.similarApiCallHandler(from: responce)
        })
    }
    func subscribeViewState(with completion: @escaping (DetailViewStatee) -> Void) {
        dataState = completion
    }
    private func apiCallHandler(from response: MovieDetailModel) {
        dataState1?(formatter.convertItemDetailView(from: response))

    }
    
    func subscribeViewStateDetailView(with completion: @escaping ItemDetailDataBlock) {
        dataState1 = completion
    }
    private func similarApiCallHandler(from response: SimilarModel) {
        formatter.setDataSimilar(with: response)
        dataState?(.detailcolletionview)
    }
    func subscribesimilarState(with completion: @escaping (DetailViewStatee) -> Void) {
        dataState = completion
    }
}
extension ItemDetailViewModel: SimilarProviderProtocol{
    func askNumberOfItemSimilar(in section: Int) -> Int {
        return formatter.getNumbeOfItemSimilar(in: section)
    }
    func askDataSimilar(at index: Int) -> GenericDataProtocol? {
        return formatter.getItemSimilar(at: index)
    }
    func selectedItemSimilar(at index: Int) {
        detailViewState?(ItemDetailViewRequest(id: formatter.getItemIdSimilar(at: index), type: .push))
    }
    func getMoreDataSimilar() {
        similarGetData()
    }
    func isLoadingCellSimilar(for index: Int) -> Bool {
        return index >= formatter.getCountSimilar()
    }
}
