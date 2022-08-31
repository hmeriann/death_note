//
//  AppDelegate.swift
//  ex00_day02
//
//  Created by Zuleykha Pavlichenkova on 03.07.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // create an instance of the UIWindow in which my app will work
    var window: UIWindow?

    // here goes the configuration of the app after it been launched
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        let rootViewController = DeathNotesAssembly().assemble()
        
        window.rootViewController = rootViewController
        
        window.makeKeyAndVisible() // в этот момент в  контроллере DeathNotesViewController вызовется ViewDidLoad
        self.window = window
        
        return true
    }
}

