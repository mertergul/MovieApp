//
//  SimilarModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 5.01.2022.
//

import Foundation

struct SimilarMoviesModel: Codable {
    let results: [Similar]
}

struct Similar: Codable {
    let id: Int
    let title: String
    let release_date: String
    let poster_path: String?
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
    var posterCheck:String{
        var data = poster_path
        if data == nil {
        data = "https://via.placeholder.com/150"
        }
        return data!
    }
}

