//
//  SimilarProviderProtocol.swift
//  MovieApp
//
//  Created by Mert Ergul on 17.04.2022.
//

import Foundation

protocol SimilarProviderProtocol:AnyObject{
    func askNumberOfItemSimilar(in section: Int) -> Int
    func askDataSimilar(at index: Int) -> GenericDataProtocol?
    func selectedItemSimilar(at index: Int)
    func getMoreDataSimilar()
    func isLoadingCellSimilar(for index: Int) -> Bool
    
}
