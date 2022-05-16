//
//  MainViewFormatterProtocol.swift
//  MovieApp
//
//  Created by Mert Ergul on 4.01.2022.
//

import Foundation

protocol MainDataFormatterProtocol: AnyObject {
    
    var paginationDataUpComing: PaginationInfoUpComing { get set }
    var paginationDataNowPlaying: PaginationInfoNowPlaying { get set }
    
    
    func getNumbeOfItemUpComing(in section: Int) -> Int
    func getNumbeOfItemNowPlaying(in section: Int) -> Int
    
    
    func getCountUpComing() -> Int
    func getCountNowPlaying() -> Int
    
    
    
    func setDataUpComing(with response: UpComingModel)
    func setDataNowPlaying(with nowPlaying: NowPlayingModel)
    
    func getItemUpComing(at index: Int) -> GenericDataProtocol?
    func getItemNowPlaying(at index: Int) -> GenericDataProtocol?
    
    func getItemIdUpComing(at index: Int) -> Int
    func getItemIdNowPlayingId(at index: Int) -> Int
    
    func fetcUpComing(response:@escaping (UpComingModel) -> Void)
    func fetchNowPlaying(responce:@escaping (NowPlayingModel) -> Void)
    
    
}

