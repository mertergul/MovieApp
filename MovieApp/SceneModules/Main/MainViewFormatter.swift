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
    func searchsetData(with response: SearchModel) {
        self.searchcomponentData = response
        self.paginationData.resultCount = response.results.count
        self.searchlistlist.append(contentsOf: response.results)
    }
    
    func searchDatas(response: @escaping (SearchModel) -> Void) {
        AF.request(MovieServiceEndPoint.searchURL()).responseDecodable(of: SearchModel.self) {
            (model) in
            guard let data = model.value else {
                return
            }
            response(data)
        }
    }
    
    func fetchAllDatas(response: @escaping (MovieModel) -> Void) {
        AF.request(MovieServiceEndPoint.upcomming()).responseDecodable(of: MovieModel.self) {
            (model) in
            guard let data = model.value else {
                return
            }
            response(data)
        }
        
    }
    
    private var componentData: MovieModel?
    private var searchcomponentData: SearchModel?
    private var list: [MovieResults] = [MovieResults]()
    private var searchlistlist: [SearchResult] = [SearchResult]()
        var paginationData: PaginationInfo = PaginationInfo()

    func getNumbeOfItem(in section: Int) -> Int {
        let count = list.count
        return (paginationData.limit <= paginationData.resultCount) ? count + 1 : count
    }
    
    func getCount() -> Int {
        return list.count
    }
    
    func setData(with response: MovieModel) {

        self.componentData = response
        self.paginationData.resultCount = response.results.count
        self.list.append(contentsOf: response.results)
    }
    
    
    func getItem(at index: Int) -> GenericDataProtocol? {
        
        return MovieListDisplayerView(imageData: CustomImageViewComponentData(imageUrl:(MovieServiceEndPoint.IMAGE_URL.rawValue+list[index].posterCheck) ),
                                      name: list[index].title + "(\(list[index].releaseYear))",
                                      title: list[index].overview ?? "",
                                      price: list[index].release_date ?? "")
    }
    
    func getItemId(at index: Int) -> Int {
        selectedId = list[index].id
        return list[index].id
    }
    func reset() {
        paginationData.offset = 0
        list.removeAll()
    }
    
}
