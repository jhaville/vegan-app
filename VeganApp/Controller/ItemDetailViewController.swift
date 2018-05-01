import UIKit
import GoogleMaps

class ItemDetailViewController: UIViewController {
  
    @IBOutlet weak var verticalScrollView: UIScrollView!
    @IBOutlet weak var mapView: UIView! {
        didSet {
            let camera = GMSCameraPosition.camera(withLatitude: 51.486060, longitude: -0.203040, zoom: 16.0)
            let map = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
            mapView.addSubview(map)

            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 51.486060, longitude: -0.203040)
            marker.map = map
        }
    }
    @IBOutlet weak var imagesStackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()

    verticalScrollView.contentInsetAdjustmentBehavior = .never

    verticalScrollView.contentInset = UIEdgeInsets(top: view.frame.width, left: 0, bottom: 0, right: 0)

    let imageView = UIImageView(image: UIImage(named: "restaurant-background"))
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false

    let imageView2 = UIImageView(image: UIImage(named: "restaurant-background"))
    imageView2.contentMode = .scaleAspectFill
    imageView2.clipsToBounds = true
    imageView2.translatesAutoresizingMaskIntoConstraints = false

    imagesStackView.addArrangedSubview(imageView)
    imagesStackView.addArrangedSubview(imageView2)
    imagesStackView.arrangedSubviews.first?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
  }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
