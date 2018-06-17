import UIKit
import CoreLocation

final class TabBarCoordinator: NSObject, Coordinator {
  
  private var coordinators: [Coordinator] = []
  private let tabBarController: UITabBarController
  
  private let restaurantsNavigationController = UINavigationController()
  private let shopsNavigationController = UINavigationController()
  
  private let restaurantsCoordinator: ItemCoordinator
  private let shopsCoordinator: ItemCoordinator

  private let locationManager = CLLocationManager()
  
  private var firstShopsLoad = true
  private var didUpdateLocation = false
  
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
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.distanceFilter = 100.0
    locationManager.delegate = self
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

extension TabBarCoordinator: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, !didUpdateLocation {
            print(location)
            didUpdateLocation = true
            restaurantsCoordinator.setUserLocation(to: location)
            restaurantsCoordinator.start()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            manager.requestLocation()
            break
        case .authorizedAlways:
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
}


