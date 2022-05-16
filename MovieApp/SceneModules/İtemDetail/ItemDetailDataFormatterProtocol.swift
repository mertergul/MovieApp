//
//  ItemDetailDataFormatterProtocol.swift
//  MovieApp
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation

protocol ItemDetailDataFormatterProtocol: AnyObject {
    
    
    func convertItemDetailView(from rawData: MovieDetailModel) -> ItemDetailViewData
    func detailDatas(response:@escaping (MovieDetailModel) -> ())
    
    var  paginationDataSimilar: PaginationInfoSimilar { get set }
    func getNumbeOfItemSimilar(in section: Int) -> Int
    func getCountSimilar() -> Int
    func setDataSimilar(with response: SimilarModel)
    func getItemSimilar(at index: Int) -> GenericDataProtocol?
    func getItemIdSimilar(at index: Int) -> Int
    func fetcSimilar(response:@escaping (SimilarModel) -> Void)
   
    

    
}
