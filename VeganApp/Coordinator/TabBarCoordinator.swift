import UIKit

final class TabBarCoordinator: Coordinator {
  
  private var coordinators: [Coordinator] = []
  private let tabBarController: UITabBarController
  
  init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
  }
  
  func start() {
    let companyListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompanyListController") as! CompanyListController

    let companyListNavigationController = UINavigationController(rootViewController: companyListController)
    tabBarController.viewControllers = [companyListNavigationController]
    
    let companyCoordinator = CompanyCoordinator(navigationController: companyListNavigationController)
    coordinators.append(companyCoordinator)
    
    companyCoordinator.start()
  }
  
  
}

