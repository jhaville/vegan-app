import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
    UINavigationBar.appearance().titleTextAttributes = textAttributes
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()

    guard let window = window else { return false }
    
    let appCoordinator = AppCoordinator(window: window)
    appCoordinator.start()

    return true
  }
}

