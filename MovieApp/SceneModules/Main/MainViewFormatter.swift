//
//  MainViewFormatter.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation
import UIKit
import Alamofire

class MainDataFormatter: MainDataFormatterProtocol {
    
    
    
    
    private var componentDataUpComing: UpComingModel?
    private var ccomponentDataNowPlaying:NowPlayingModel?
    
    private var listUpComing: [UpComingResults] = [UpComingResults]()
    private var listNowPlaying: [NowPlayingResults] = [NowPlayingResults]()
   
    var paginationDataUpComing: PaginationInfoUpComing = PaginationInfoUpComing()
    var paginationDataNowPlaying:PaginationInfoNowPlaying = PaginationInfoNowPlaying()
    
    func fetchNowPlaying(responce: @escaping (NowPlayingModel) -> Void) {
        AF.request(MovieServiceEndPoint.nowPlaying()).validate().responseDecodable(of: NowPlayingModel.self) {
            (nowPlaying) in
            guard let data = nowPlaying.value else {return}
            responce(data)
        }
    }
    func fetcUpComing(response: @escaping (UpComingModel) -> Void) {
        AF.request(MovieServiceEndPoint.upcoming()).responseDecodable(of: UpComingModel.self) {
            (model) in
            guard let data = model.value else {
                return
            }
            response(data)
        }
    }
    func getNumbeOfItemUpComing(in section: Int) -> Int {
        let count = listUpComing.count
        return (paginationDataUpComing.limit <= paginationDataUpComing.resultCount) ? count + 1 : count
    }
    func getNumbeOfItemNowPlaying(in section: Int) -> Int {
        let count = listNowPlaying.count
        return (paginationDataNowPlaying.limit <= paginationDataNowPlaying.resultCount) ? count + 1 : count
    }
    
    func getCountUpComing() -> Int {
        return listUpComing.count
    }
    func getCountNowPlaying() -> Int {
        return listNowPlaying.count
    }
    
    func setDataUpComing(with response: UpComingModel) {
        self.componentDataUpComing = response
        self.paginationDataUpComing.resultCount = response.results.count
        self.listUpComing.append(contentsOf: response.results)
    }
    func setDataNowPlaying(with nowPlaying: NowPlayingModel) {
        self.ccomponentDataNowPlaying = nowPlaying
        self.paginationDataNowPlaying.resultCount = nowPlaying.results.count
        
        self.listNowPlaying.append(contentsOf: nowPlaying.results)
    }
    
    
    
    func getItemUpComing(at index: Int) -> GenericDataProtocol? {
        return MovieListDisplayerView(imageData: CustomImageViewComponentData(imageUrl:(MovieServiceEndPoint.IMAGE_URL.rawValue+listUpComing[index].posterCheck) ),
                                      name: listUpComing[index].title + "(\(listUpComing[index].releaseYear))",
                                      title: listUpComing[index].overview ?? "",
                                      date: listUpComing[index].release_date ?? "")
    }
    func getItemNowPlaying(at index: Int) -> GenericDataProtocol? {
        return NowPlayingDisplayerViewData(imageData: CustomImageViewComponentData(imageUrl: (MovieServiceEndPoint.IMAGE_DETAIL.rawValue+listNowPlaying[index].posterCheck)),
                                           name: listNowPlaying[index].title + " (\(listNowPlaying[index].releaseYear))",
                                           title:listNowPlaying[index].overview ?? "",
                                           date: listNowPlaying[index].release_date ?? "")
    }
    func getItemIdUpComing(at index: Int) -> Int {
        selectedId = listUpComing[index].id
        return listUpComing[index].id
    }
    func getItemIdNowPlayingId(at index: Int) -> Int {
        selectedId = listNowPlaying[index].id
        return listNowPlaying[index].id
    }
    
   
    
    
    
}
