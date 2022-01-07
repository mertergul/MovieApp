//
//  SimilarListViewComponentViewData.swift
//  MovieApp
//
//  Created by Mert Ergul on 6.01.2022.
//

import Foundation

class SimilarListViewComponentViewData: GenericDataProtocol {
    
    
    private(set) var imageData: CustomImageViewComponentData
    private(set) var name: String
  

    
    init(imageData: CustomImageViewComponentData,
         name: String) {
        self.imageData = imageData
        self.name = name
  
  
    }
    
}
