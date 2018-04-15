import UIKit

final class CompanyCoordinator: Coordinator {
  
  private let coordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {}
}


