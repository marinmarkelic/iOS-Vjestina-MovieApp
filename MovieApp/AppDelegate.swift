//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Marin on 19.03.2022..
//

import UIKit
import MovieAppData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MovieListViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        
        return true
    }
}

