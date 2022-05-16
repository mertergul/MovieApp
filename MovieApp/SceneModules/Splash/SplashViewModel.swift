//
//  SplashViewModel.swift
//  MovieApp
//
//  Created by Mert Ergul on 3.01.2022.
//
import Foundation

typealias VoidBlock = () -> Void

class SplashViewModel {
    
    private var splashFinalizeListener: VoidBlock?
    
    init(completion: @escaping VoidBlock) {
        self.splashFinalizeListener = completion
    }
    
    func fireApplicationInitiateProcess() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.splashFinalizeListener?()
        }
        
    }
    
}
