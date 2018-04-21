import UIKit

final class TabBarCoordinator: NSObject, Coordinator {
  
  private var coordinators: [Coordinator] = []
  private let tabBarController: UITabBarController
  
  private let restaurantsNavigationController = UINavigationController()
  private let shopsNavigationController = UINavigationController()
  
  private let restaurantsCoordinator: Coordinator
  private let shopsCoordinator: Coordinator
  
  private var firstShopsLoad = true
  
  init(tabBarController: UITabBarController) {
    restaurantsCoordinator = ItemCoordinator(navigationController: restaurantsNavigationController, itemType: .restaurant)
    shopsCoordinator = ItemCoordinator(navigationController: shopsNavigationController, itemType: .shop)
    self.tabBarController = tabBarController
    super.init()
    setup()
  }
  
  private func setup() {
    tabBarController.setViewControllers([restaurantsNavigationController, shopsNavigationController], animated: false)
    restaurantsNavigationController.tabBarItem.image = UIImage(named: "restaurants")
    restaurantsNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

    shopsNavigationController.tabBarItem.image = UIImage(named: "shops")
    shopsNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

    coordinators.append(restaurantsCoordinator)
    coordinators.append(shopsCoordinator)
    tabBarController.delegate = self
  }
  
  func start() {
    restaurantsCoordinator.start()
  }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if viewController == shopsNavigationController, firstShopsLoad {
      shopsCoordinator.start()
      firstShopsLoad = false
    }
  }
}
