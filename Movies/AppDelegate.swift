//
//  AppDelegate.swift
//  Movies
//
//  Created by Daniel Amaral on 01/03/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        TMDbClient.shared.getConfiguration()
        let configuration = ParseClientConfiguration {
            $0.server = "https://cloud-dev.ilhasoft.mobi/ilhamovies"
            $0.applicationId = "7WzwMRCDGkK6UtJJO632n9U3qHNakWxPppKrtWed"
            $0.clientKey = "oR6aVlWr0EDbPy2FH6vqTDmUYRgCw7tOOK6TeatK"
        }
        Parse.initialize(with: configuration)
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
        setupWindow()
        return true
    }

    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white

        if MVUser.current() != nil {
            window?.rootViewController = UINavigationController(rootViewController: MVMoviesViewController())
        } else {
            window?.rootViewController = MVOnboardingViewController()
        }

        window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    private func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
}
