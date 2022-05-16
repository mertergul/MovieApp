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
    public func getUpComing() {
        mainViewState?(.loading)
        dataFormatter.fetcUpComing(response: { [weak self](responce) in
            self?.apiCallHandler(from: responce)})
    }
    public func getNowPlaying() {
        mainViewState?(.loading)
        dataFormatter.fetchNowPlaying(responce: { [weak self](responce) in
            self?.apiCallHandlerNowPlaying(from: responce)})
    }
    func subscribeViewState(with completion: @escaping (ViewState) -> Void) {
        mainViewState = completion
    }
    func subscribeDetailViewState(with completion: @escaping ItemDetailRequestBlock) {
        detailViewState = completion
    }
    private func apiCallHandler(from response: UpComingModel) {
        dataFormatter.setDataUpComing(with: response)
        mainViewState?(.doneUpComing)
    }
    private func apiCallHandlerNowPlaying(from response: NowPlayingModel) {
        dataFormatter.setDataNowPlaying(with: response)
        mainViewState?(.doneNowPlaying)
    }
}
extension MainViewModel: ItemProviderProtocol,NowPlayingProviderProtocol {
    func askNumberOfItemNowPlaying(in section: Int) -> Int {
        return dataFormatter.getNumbeOfItemNowPlaying(in: section)
    }
    func askDataNowPlaying(at index: Int) -> GenericDataProtocol? {
        return dataFormatter.getItemNowPlaying(at: index)
    }
    func selectedItemNowPlaying(at index: Int) {
        detailViewState?(ItemDetailViewRequest(id: dataFormatter.getItemIdNowPlayingId(at: index), type: .push))
    }
    func getMoreDataNowPlaying() {
        getNowPlaying()
    }
    func isLoadingCellNowPlaying(for index: Int) -> Bool {
        return index >= dataFormatter.getCountNowPlaying()
    }
    func askNumberOfItem(in section: Int) -> Int {
        return dataFormatter.getNumbeOfItemUpComing(in: section)
    }
    func askData(at index: Int) -> GenericDataProtocol? {
        return dataFormatter.getItemUpComing(at: index)
    }
    func isLoadingCell(for index: Int) -> Bool {
        return index >= dataFormatter.getCountUpComing()
    }
    func getMoreData() {
        getUpComing()
    }
    func selectedItem(at index: Int) {
        detailViewState?(ItemDetailViewRequest(id: dataFormatter.getItemIdUpComing(at: index), type: .push))
    }
}

