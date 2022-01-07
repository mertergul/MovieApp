//
//  ItemDetailViewBuilder.swift
//  iTunes Search
//
//  Created by Mert Ergul on 21.11.2021.
//

import Foundation
import UIKit

class ItemDetailViewBuilder {
    
    class func build(with data: ItemDetailViewRequest) -> UIViewController {
        let formatter = ItemDetailDataFormatter()
        let viewModel = ItemDetailViewModel(data: data, formatter: formatter)
        return ItemDetailViewController(viewModel: viewModel)
    }
    
}

