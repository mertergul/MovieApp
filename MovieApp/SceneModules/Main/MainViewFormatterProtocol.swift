//
//  MainViewFormatterProtocol.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation

protocol MainDataFormatterProtocol: AnyObject {
    
    var paginationData: PaginationInfo { get set }
    func getNumbeOfItem(in section: Int) -> Int
    func getCount() -> Int
    func setData(with response: MovieModel)
    func searchsetData(with response: SearchModel)
    func getItem(at index: Int) -> GenericDataProtocol?
    func getItemId(at index: Int) -> Int
    func reset()
    func fetchAllDatas(response:@escaping (MovieModel) -> Void)
    func searchDatas(response:@escaping (SearchModel) -> Void)
}
