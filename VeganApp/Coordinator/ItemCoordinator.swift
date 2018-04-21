import UIKit

final class ItemCoordinator: Coordinator {
  
  private let coordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let itemType: ItemType
  private let itemListController: ItemListController
  private let firebaseService = FirebaseServiceImpl()
  private let restaurantsTitle = "Restaurants"
  private let shopsTitle = "Shops"
  
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

