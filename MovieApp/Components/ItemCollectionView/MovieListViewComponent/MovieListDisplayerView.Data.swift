//
//  MovieListDisplayerView.Data.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation

class MovieListDisplayerView: GenericDataProtocol {
    
    
    private(set) var imageData: CustomImageViewComponentData
    private(set) var name: String
    private(set) var title: String
    private(set) var date: String
    
    private(set) var isInfoViewHidden: Bool = false
    
    init(imageData: CustomImageViewComponentData,
         name: String,
         title: String,
         date: String,
         isInfoViewHidden: Bool = false) {
        self.imageData = imageData
        self.name = name
        self.title = title
        self.date = date
        self.isInfoViewHidden = isInfoViewHidden
    }
    
}

