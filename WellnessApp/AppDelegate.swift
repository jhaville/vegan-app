import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var appCoordinator: AppCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    GMSServices.provideAPIKey("AIzaSyC_25KzLLIViOOvkQR7mVlNA8qE05gim68")
    
    styleApp()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    appCoordinator = AppCoordinator(window: window ?? UIWindow())
    appCoordinator?.start()
  
    return true
  }
  
  private func styleApp() {
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    UITabBar.appearance().tintColor = .black
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], for: .normal)
  }
}

