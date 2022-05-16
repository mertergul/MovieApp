//
//  NowPlayingProviderProtocol.swift
//  MovieApp
//
//  Created by Mert Ergul on 31.03.2022.
//

import Foundation

protocol NowPlayingProviderProtocol: AnyObject{

    func askNumberOfItemNowPlaying(in section: Int) -> Int
    func askDataNowPlaying(at index: Int) -> GenericDataProtocol?
    func selectedItemNowPlaying(at index: Int)
    func getMoreDataNowPlaying()
    func isLoadingCellNowPlaying(for index: Int) -> Bool
    
}

	
