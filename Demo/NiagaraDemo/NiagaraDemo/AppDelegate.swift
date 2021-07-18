/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = makeWindow()
    }

    private func makeWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let waterfallLayoutVC = WaterfallLayoutViewController()
        let navigationController = UINavigationController(rootViewController: waterfallLayoutVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return window
    }
}
