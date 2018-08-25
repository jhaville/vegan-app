import UIKit
import CoreLocation

final class ItemCoordinator: Coordinator {
  
  private let coordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private let itemType: ItemType
  private let itemListController: ItemListController
  private let apiService = APIService()
  private let mapService = MapService()
  private var location: CLLocation?
  private var cursor: Int = 0
  private let numOfItemsPerRequest = 10
  private var currentItems = [Item]()
  weak var delegate: ItemListControllerDelegate?

  init(navigationController: UINavigationController, itemType: ItemType) {
    self.navigationController = navigationController
    self.itemType = itemType
    self.itemListController = UIViewController.load(ItemListController.self)
    itemListController.title = itemType.toCollectionName().capitalized
  }
  
  func update(with location: CLLocation) {
    self.location = location
    
    guard let urlRequest = apiService.itemRequest(location: location, cursor: cursor, numOfItems: numOfItemsPerRequest, itemType: itemType) else {
      return
    }

    apiService.load(resource: Resource<Items>(urlRequest: urlRequest)) { (error, response) in
      self.cursor = response?.cursor ?? 0
      self.handleItemResponse(error, response?.items)
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
        let allItems = self.currentItems + items
        guard self.currentItems != allItems else {
          self.itemListController.clearLoadingFooter()
          return
        }
        let initialItemCount = self.currentItems.count
        self.currentItems = allItems
        let itemsViewModel = ItemsViewModel(with: allItems)
        let newIndexPaths = items.enumerated().map { IndexPath(row: initialItemCount + $0.offset, section: 0) }
        let isInitialData = self.currentItems.count == self.numOfItemsPerRequest
        self.itemListController.update(with: ViewState.data(itemsViewModel), indexPaths: isInitialData ? [] : newIndexPaths)
      }
    }
  }
}

extension ItemCoordinator: ItemListControllerDelegate {
  
  func didSelect(_ viewController: ItemListController, itemViewModel: ItemViewModel) {
    let itemDetailController = UIViewController.load(ItemDetailViewController.self)
    itemDetailController.loadViewIfNeeded()
    navigationController.pushViewController(itemDetailController, animated: true)
    itemDetailController.delegate = self
    itemDetailController.update(with: itemViewModel)
  }
  
  func didRefresh(_ viewController: ItemListController) {
    self.cursor = 0
    self.currentItems = []
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
  
  func viewDidAppearCalled(_ controller: ItemDetailViewController, viewModel: ItemViewModel) {
    controller.updateLocation(with: viewModel)
  }
  
  func didRequestMoreItems(_ viewController: ItemListController) {
    if let location = location {
      update(with: location)
    }
  }
}

