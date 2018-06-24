import UIKit
import GoogleMaps

protocol ItemDetailViewControllerDelegate: class {
    func didTapBackButton(_ controller: ItemDetailViewController)
    func didTapShowMeDirectionsButton(_ controller: ItemDetailViewController, with coordinates: [Double])
}

class ItemDetailViewController: UIViewController {
  
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.didTapBackButton(self)
    }

    @IBAction func showMeDirectionsButtonTapped(_ sender: Any) {
        if let coordinates = coordinates {
            delegate?.didTapShowMeDirectionsButton(self, with: coordinates)
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shortSummaryLabel: UILabel!
    @IBOutlet weak var websiteUrlLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var verticalScrollView: UIScrollView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var imagesStackView: UIStackView!
    weak var delegate: ItemDetailViewControllerDelegate?
    private var coordinates: [Double]?

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

        coordinates = viewModel.coordinates

        nameLabel.text = viewModel.name
        shortSummaryLabel.text = viewModel.shortSummary
        phoneNumberLabel.text = viewModel.phoneNumber
        descriptionLabel.text = viewModel.description
        websiteUrlLabel.text = viewModel.websiteUrl?.absoluteString

        viewModel.imageUrls?.forEach {
          let networkUIImageView = NetworkUIImageView()
          networkUIImageView.loadImage(from: $0)
          networkUIImageView.contentMode = .scaleAspectFill
          networkUIImageView.clipsToBounds = true
          networkUIImageView.translatesAutoresizingMaskIntoConstraints = false
          imagesStackView.addArrangedSubview(networkUIImageView)
        }
        imagesStackView.arrangedSubviews.first?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        let camera = GMSCameraPosition.camera(withLatitude: viewModel.latitude, longitude: viewModel.longitude, zoom: 16.0)
        let map = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
        mapView.addSubview(map)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
        marker.map = map
    }
}
