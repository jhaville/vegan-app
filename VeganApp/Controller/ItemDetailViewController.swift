import UIKit
import GoogleMaps

protocol ItemDetailViewControllerDelegate: class {
    func didTapBackButton(controller: ItemDetailViewController)
}

class ItemDetailViewController: UIViewController {
  
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.didTapBackButton(controller: self)
    }
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
    weak var delegate: ItemDetailViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    verticalScrollView.contentInsetAdjustmentBehavior = .never
    verticalScrollView.contentInset = UIEdgeInsets(top: view.frame.width, left: 0, bottom: 0, right: 0)
  }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    func update(with viewModel: ItemViewModel) {
        viewModel.imageUrls?.forEach {
          let networkUIImageView = NetworkUIImageView()
          networkUIImageView.loadImage(from: $0)
          networkUIImageView.contentMode = .scaleAspectFill
          networkUIImageView.clipsToBounds = true
          networkUIImageView.translatesAutoresizingMaskIntoConstraints = false
          self.imagesStackView.addArrangedSubview(networkUIImageView)
        }
        imagesStackView.arrangedSubviews.first?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    }
}
