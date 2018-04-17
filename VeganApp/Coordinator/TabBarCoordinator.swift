import UIKit

final class TabBarCoordinator: NSObject, Coordinator {
  
  private var coordinators: [Coordinator] = []
  private let tabBarController: UITabBarController
  private let restaurantsNavigationController = UINavigationController()
  private let shopsNavigationController = UINavigationController()
  private let restaurantsCoordinator: Coordinator
  private let shopsCoordinator: Coordinator
  
  init(tabBarController: UITabBarController) {
    restaurantsCoordinator = ItemCoordinator(navigationController: restaurantsNavigationController, itemListType: .restaurant)
    shopsCoordinator = ItemCoordinator(navigationController: shopsNavigationController, itemListType: .shop)
    self.tabBarController = tabBarController
    super.init()
    setup()
  }
  
  private func setup() {
    tabBarController.setViewControllers([restaurantsNavigationController, shopsNavigationController], animated: false)
    restaurantsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
    shopsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    coordinators.append(restaurantsCoordinator)
    coordinators.append(shopsCoordinator)
    tabBarController.delegate = self
  }
  
  func start() {
    restaurantsCoordinator.start()
    shopsCoordinator.start()
  }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    
  }
}

extension TabBarCoordinator: UITabBarDelegate {
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    
  }
}
