import UIKit
import GoogleMaps

class ItemDetailViewController: UIViewController {
  
  @IBOutlet weak var mapView: GMSMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
  }
  
  
}
