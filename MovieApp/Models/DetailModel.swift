//
//  DetailModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation

struct MovieDetailModel: Codable {
    let title: String
    let overview: String
    let release_date: String
    let vote_average: Double
    let poster_path: String
    let imdb_id: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}
