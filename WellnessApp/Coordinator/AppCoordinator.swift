import UIKit
import CoreLocation

protocol Coordinator: class {
  func start()
}

final class AppCoordinator: NSObject, Coordinator {
  
  private let window: UIWindow
  private let tabBarController = UITabBarController()
  private var coordinators = [Coordinator]()
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    showTabs()
  }
  
  private func showTabs() {
    window.rootViewController = tabBarController
    
    let tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController)
    tabBarCoordinator.start()
    coordinators.append(tabBarCoordinator)
  }
}
