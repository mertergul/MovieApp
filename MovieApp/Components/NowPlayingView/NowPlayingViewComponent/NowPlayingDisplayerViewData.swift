//
//  NowPlayingDisplayerViewData.swift.swift
//  MovieApp
//
//  Created by Mert Ergul on 31.03.2022.
//



import Foundation

class NowPlayingDisplayerViewData: GenericDataProtocol {
    
    
    private(set) var imageData: CustomImageViewComponentData
    private(set) var name: String
    private(set) var title: String
    private(set) var date: String
    

    
    init(imageData: CustomImageViewComponentData,
         name: String,
         title: String,
         date: String,
         isInfoViewHidden: Bool = false) {
        self.imageData = imageData
        self.name = name
        self.title = title
        self.date = date

    }
    
}

