//
//  MovieService.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Alamofire
public var pageNumber = 1
public var selectedId = 1
public var query = ""

enum MovieServiceEndPoint: String {
    
    case BASE_URL = "https://api.themoviedb.org/3/movie/"
    case PATH_UPCOMMING = "upcoming?"
    case API_KEY = "api_key=4d5404d17cd1992efe0e289777159040"
    case IMAGE_URL = "https://image.tmdb.org/t/p/w200"
    case IMAGE_DETAIL = "https://image.tmdb.org/t/p/w500"
    case PAGE_URL = "&page="
    case IMAGE = "https://via.placeholder.com/150"
    case SIMILAR = "/similar?"
    case SEARCHURL = "https://api.themoviedb.org/3/search/movie?api_key=4d5404d17cd1992efe0e289777159040&query="
    
    static func upcomming() -> String {
        return "\(BASE_URL.rawValue)\(PATH_UPCOMMING.rawValue)\(API_KEY.rawValue)\(PAGE_URL.rawValue)\(pageNumber)"
    }
    static func detailURL() -> String {
        return "\(BASE_URL.rawValue)\(selectedId)?\(API_KEY.rawValue)"
    }
    static func detailSimilarURL() -> String{
        return ("\(BASE_URL.rawValue)\(selectedId)\(SIMILAR.rawValue)\(API_KEY.rawValue)")
    }
    static func searchURL() -> String {
        return ("\(SEARCHURL.rawValue)\(query)")
    }
}

    
    

