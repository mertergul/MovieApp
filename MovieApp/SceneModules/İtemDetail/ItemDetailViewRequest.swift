//
//  ItemDetailViewRequest.swift
//  MovieApp
//
//  Created by Mert Ergul on 1.11.2021.
//

import Foundation

typealias ItemDetailRequestBlock = (ItemDetailViewRequest) -> Void

class ItemDetailViewRequest {
    private(set) var id: Int
    private(set) var type: ItemDetailViewPresentationType
    
    init(id: Int, type: ItemDetailViewPresentationType = .push) {
        self.id = id
        self.type = type
    }
}
