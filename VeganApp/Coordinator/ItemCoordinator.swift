import UIKit

final class ItemCoordinator: Coordinator {
  
  private let coordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let itemType: ItemType
  private let itemListController: ItemListController
  private let firebaseService = FirebaseServiceImpl()
  private let restaurantsTitle = "Restaurants"
  private let shopsTitle = "Shops"
  weak var delegate: ItemListControllerDelegate?
  
  init(navigationController: UINavigationController, itemType: ItemType) {
    self.navigationController = navigationController
    self.itemType = itemType
    self.itemListController = UIViewController.load(ItemListController.self)
    itemListController.title = itemType == .restaurant ? restaurantsTitle : shopsTitle
  }

  func start() {
    itemListController.loadViewIfNeeded()
    itemListController.update(with: .loading)
    itemListController.itemType = itemType
    itemListController.delegate = self
    firebaseService.getItems(of: itemType, completion: { error, items in
        self.handleItemReponse(error, items)
    })
    navigationController.viewControllers = [itemListController]
  }
  
  private func handleItemReponse(_ error: Error?, _ items: [Item]?) {
    DispatchQueue.main.async {
      if error != nil { self.itemListController.update(with: ViewState.error(error)) }
      if let items = items {
        let itemsViewModel = ItemsViewModel(with: items)
        self.itemListController.update(with: ViewState.data(itemsViewModel))
      }
    }
  }
}

extension ItemCoordinator: ItemListControllerDelegate {
  func didSelect(_ viewController: ItemListController, itemViewModel: ItemViewModel) {
    let itemDetailController = UIViewController.load(ItemDetailViewController.self)
    itemDetailController.loadViewIfNeeded()
    itemDetailController.delegate = self
    itemDetailController.update(with: itemViewModel)
    navigationController.pushViewController(itemDetailController, animated: true)
  }
}

extension ItemCoordinator: ItemDetailViewControllerDelegate {
    func didTapBackButton(controller: ItemDetailViewController) {
        navigationController.popViewController(animated: true)
    }
}

