//
//  SearchModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 7.01.2022.
//

import Foundation

struct SearchModel: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let id: Int
    let title: String
    let release_date: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}
