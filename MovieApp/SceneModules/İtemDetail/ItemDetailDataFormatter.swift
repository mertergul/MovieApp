//
//  ItemDetailDataFormatter.swift
//  MovieApp
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation
import UIKit
import Alamofire

class ItemDetailDataFormatter: ItemDetailDataFormatterProtocol {
    
    var paginationDataSimilar: PaginationInfoSimilar = PaginationInfoSimilar()
    private var listSimilar: [SimilarModelResults] = [SimilarModelResults]()
    private var componentDataSimilar : SimilarModel?
    
    func getNumbeOfItemSimilar(in section: Int) -> Int {
        let count = listSimilar.count
        return (paginationDataSimilar.limit <= paginationDataSimilar.resultCount) ? count + 1 : count
    }
    
    func getCountSimilar() -> Int {
        return listSimilar.count
    }
    
    func setDataSimilar(with response: SimilarModel) {
        self.componentDataSimilar = response
        self.paginationDataSimilar.resultCount = response.results.count
        self.listSimilar.append(contentsOf: response.results)
    }
    
    func getItemSimilar(at index: Int) -> GenericDataProtocol? {
        return SimilarDisPlayerViewData(imageData: CustomImageViewComponentData(imageUrl: (MovieServiceEndPoint.IMAGE_URL.rawValue+listSimilar[index].posterCheck)),
                                        name: listSimilar[index].title + " (\(listSimilar[index].releaseYear))",
                                        title:listSimilar[index].overview ?? "",
                                        date: listSimilar[index].release_date ?? "")
    }
    
    func getItemIdSimilar(at index: Int) -> Int {
        selectedId = listSimilar[index].id
        return listSimilar[index].id
    }
    
    func fetcSimilar(response: @escaping (SimilarModel) -> Void) {
        AF.request(MovieServiceEndPoint.detailSimilarURL()).responseDecodable(of: SimilarModel.self) {
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
            infoView: rawData.title + " (\(rawData.releaseYear))",
            ratingLabel: String(rawData.vote_average)+"/10",
            deatilDate: rawData.release_date,
            destLabel: rawData.overview)
    }
 
}


