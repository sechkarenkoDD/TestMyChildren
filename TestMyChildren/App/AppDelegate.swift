//
//  AppDelegate.swift
//  TestMyChildren
//
//  Created by Дмитрий Сечкаренко on 25.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemGray5
        window?.rootViewController = ChildrenListViewController(
            viewModel: ChildViewModelImpl()
        )
        return true
    }

}

