import UIKit

enum ItemListType {
  case restaurant
  case shop
}

final class ItemCoordinator: Coordinator {
  
  private let coordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let itemListType: ItemListType
  private let rootViewController: ItemListController
  private let firebaseService = FirebaseService()
  
  init(navigationController: UINavigationController, itemListType: ItemListType) {
    self.navigationController = navigationController
    self.itemListType = itemListType
    self.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemListController") as! ItemListController
    rootViewController.title = itemListType == .restaurant ? "Restaurants" : "Shops"
  }
  
  func start() {
    switch itemListType {
    case .restaurant:
      rootViewController.loadViewIfNeeded()
      rootViewController.setState(to: .loading)
      rootViewController.listItemType = .restaurant
      firebaseService.getItems(of: .restaurant, completion: { items in
        DispatchQueue.main.async {
          self.rootViewController.items = items
          self.rootViewController.setState(to: .default)
        }
      })
//      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
//        let items = (0...6).map { _ in Item(name: "", location: "", coordinates: Coordinates(longitude: 0, latitude: 0), imageUrls: nil, websiteUrl: nil, itemType: .restaurant) }
//      })
    case .shop:
      rootViewController.loadViewIfNeeded()
      rootViewController.setState(to: .loading)
      rootViewController.listItemType = .shop
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
        let items = (0...6).map { _ in Item(name: "", location: "", coordinates: Coordinates(longitude: 0, latitude: 0), imageUrls: nil, websiteUrl: nil, itemType: .restaurant) }
        self.rootViewController.items = items
        self.rootViewController.setState(to: .default)
    })
    }
    navigationController.viewControllers = [rootViewController]
  }
  
}

