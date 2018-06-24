import UIKit
import CoreLocation

final class ItemCoordinator: Coordinator {
  
  private let coordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let itemType: ItemType
  private let itemListController: ItemListController
  private let firebaseService = FirebaseServiceImpl()
  private let apiService = APIService()
  private let mapService = MapService()
  private let restaurantsTitle = "Restaurants"
  private let shopsTitle = "Shops"
  private var location: CLLocation?
  weak var delegate: ItemListControllerDelegate?
  
  init(navigationController: UINavigationController, itemType: ItemType) {
    self.navigationController = navigationController
    self.itemType = itemType
    self.itemListController = UIViewController.load(ItemListController.self)
    itemListController.title = itemType == .restaurant ? restaurantsTitle : shopsTitle
  }

  func update(with location: CLLocation) {
    self.location = location
    let item = Resource<Items>(url: URL(string: "http://localhost:3000/" + itemType.toCollectionName() + "?lat=" + "\(location.coordinate.latitude)" + "&long=" + "\(location.coordinate.longitude)")!)
    apiService.load(resource: item) { (error, item) in
        self.handleItemResponse(error, item?.items)
    }
  }

  func start() {
    itemListController.loadViewIfNeeded()
    itemListController.update(with: .loading)
    itemListController.itemType = itemType
    itemListController.delegate = self
    navigationController.viewControllers = [itemListController]
  }

  private func handleItemResponse(_ error: Error?, _ items: [Item]?) {
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
  func didRefresh(_ viewController: ItemListController) {
    if let location = location {
        update(with: location)
    }
  }
}

extension ItemCoordinator: ItemDetailViewControllerDelegate {
    func didTapBackButton(_ controller :ItemDetailViewController) {
        navigationController.popViewController(animated: true)
    }

    func didTapShowMeDirectionsButton(_ controller: ItemDetailViewController, with coordinates: [Double]) {
        mapService.showDirectionsWithGoogleMaps(to: coordinates)
    }
}

