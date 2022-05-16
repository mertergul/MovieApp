//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Mert Ergul on 2.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        let mainView = SplashViewBuilder.build {
//        splash finalize
            self.initializeMainView()
        }
        
        window?.rootViewController = mainView
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        return true
    }
    private func initializeMainView() {
        DispatchQueue.main.async {
//            MainView transition animation
            UIView.transition(with: self.window!, duration: 2, options: .transitionCrossDissolve) {
                self.fireMainView()
            }
        }
    }
    
    private func fireMainView() {
        let mainView = MainViewBuilder.build()
        
        
        window?.rootViewController = mainView
        window?.makeKeyAndVisible()
    }


}
