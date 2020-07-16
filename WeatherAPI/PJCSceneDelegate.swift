//
//  PJCSceneDelegate.swift
//  WeatherAPI
//
//  Created by Peter Spencer on 14/07/2020.
//  Copyright © 2020 Peter Spencer. All rights reserved.
//

import UIKit


class PJCSceneDelegate: UIResponder, UIWindowSceneDelegate
{
    // MARK: - Property(s)
    
    var window: UIWindow?


    // MARK: - Connecting and Disconnecting the Scene
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else
        { return }
        
        let controller = PJCWeatherViewController()
        let navigation = UINavigationController(rootViewController: controller)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
}

