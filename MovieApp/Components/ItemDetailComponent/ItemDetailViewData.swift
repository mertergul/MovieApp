//
//  ItemDetailViewData.swift
//  WeatherApplication
//
//  Created by Mert Ergul on 24.10.2021.
//

import Foundation
import UIKit

class ItemDetailViewData: GenericDataProtocol {
    
    private(set) var imageData: CustomImageViewComponentData
    
    private(set) var infoView: String
    private(set) var ratingLabel: String
    private(set) var deatilDate: String
    private(set) var destLabel: String
    
    init(imageData: CustomImageViewComponentData,
         infoView: String,ratingLabel: String,deatilDate: String,destLabel: String) {
        
        self.imageData = imageData
        self.infoView = infoView
        self.ratingLabel = ratingLabel
        self.deatilDate = deatilDate
        self.destLabel = destLabel
        
    }
    
}


   
    

