//
//  ItemProviderProtocol.swift
//  MovieApp
//
//  Created by Mert Ergul on 1.11.2021.
//

import Foundation

protocol ItemProviderProtocol: AnyObject {
    
//    func askNumberOfSection() -> Int
    func askNumberOfItem(in section: Int) -> Int
    func askData(at index: Int) -> GenericDataProtocol?
    func selectedItem(at index: Int)
    func getMoreData()
    func isLoadingCell(for index: Int) -> Bool
    
}
