import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var appCoordinator: AppCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    FirebaseApp.configure()
    
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

