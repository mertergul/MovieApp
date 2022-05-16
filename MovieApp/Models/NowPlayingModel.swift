//
//  NowPlayingModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 31.03.2022.
//

import Foundation

public struct NowPlayingModel: Codable {
    let results: [NowPlayingResults]
}

struct NowPlayingResults: Codable {
    let id: Int
    let poster_path: String?
    let title: String
    let backdrop_path: String?
    let overview: String?
    let release_date: String?
    
    var releaseYear:String {
        let year = release_date?.split(separator: "-").first?.description ?? "TBA"
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
