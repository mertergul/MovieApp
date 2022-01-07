//
//  ItemDetailDataFormatter.swift
//  iTunes Search
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation
import UIKit
import Alamofire

class ItemDetailDataFormatter: ItemDetailDataFormatterProtocol {
    func getNumbeOfItem(in section: Int) -> Int {
        let count = list.count
        return (paginationData.limit <= paginationData.resultCount) ? count + 1 : count
    }
    func getItem(at index: Int) -> GenericDataProtocol? {
        return SimilarListViewComponentViewData(imageData: CustomImageViewComponentData(imageUrl:(MovieServiceEndPoint.IMAGE_URL.rawValue+list[index].posterCheck) ), name: list[index].title)
    }
    private var componentData: SimilarMoviesModel?
    private var list: [Similar] = [Similar]()
    var paginationData: PaginationInfo = PaginationInfo()
    func setData(with response: SimilarMoviesModel) {
        self.componentData = response
        self.paginationData.resultCount = response.results.count
        self.list.append(contentsOf: response.results)
    }
    
    func detailDatasSmilar(response: @escaping (SimilarMoviesModel) -> Void) {
        AF.request(MovieServiceEndPoint.detailSimilarURL()).responseDecodable(of: SimilarMoviesModel.self) {
            (model) in
            guard let data = model.value else {
                return
            }
            response(data)
        }
    }
    func detailDatas(response: @escaping (MovieDetailModel) -> ()) {
        AF.request(MovieServiceEndPoint.detailURL()).responseDecodable(of: MovieDetailModel.self) {
            (model) in
            guard let data = model.value else {
                return
            }
            response(data)
        }}
    
    func convertItemDetailView(from rawData: MovieDetailModel) -> ItemDetailViewData {
       
        return ItemDetailViewData(
            imageData: CustomImageViewComponentData(imageUrl: (MovieServiceEndPoint.IMAGE_DETAIL.rawValue + rawData.poster_path)),
            infoView: rawData.title + " (\(rawData.releaseYear)",
            ratingLabel: String(rawData.vote_average),
            deatilDate: rawData.release_date, destLabel: rawData.overview)
    }
    func getCount() -> Int {
        return list.count
    }
    func getItemId(at index: Int) -> Int {
        return list[index].id
        
    }
}


