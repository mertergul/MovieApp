//
//  ItemDetailDataFormatterProtocol.swift
//  iTunes Search
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation

protocol ItemDetailDataFormatterProtocol {
    
    func convertItemDetailView(from rawData: MovieDetailModel) -> ItemDetailViewData
    func detailDatas(response:@escaping (MovieDetailModel) -> ())
    func getNumbeOfItem(in section: Int) -> Int
    func detailDatasSmilar(response:@escaping (SimilarMoviesModel) -> Void )
    func setData(with response: SimilarMoviesModel)
    func getItem(at index: Int) -> GenericDataProtocol?
    func getCount() -> Int
    func getItemId(at index: Int) -> Int
}
