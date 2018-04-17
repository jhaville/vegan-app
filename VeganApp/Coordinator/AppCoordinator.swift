import UIKit

protocol Coordinator: class {
  func start()
}

final class AppCoordinator: Coordinator {
  
  private let window: UIWindow
  private var coordinators = [Coordinator]()
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    showTabs()
  }
  
  private func showTabs() {
    let tabBarController = UITabBarController()
    window.rootViewController = tabBarController
    
    let tabBarCoordinator = TabBarCoordinator(tabBarController: tabBarController)
    tabBarCoordinator.start()
    coordinators.append(tabBarCoordinator)
  }
}
