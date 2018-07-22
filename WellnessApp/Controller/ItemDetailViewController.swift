import UIKit
import GoogleMaps

protocol ItemDetailViewControllerDelegate: class {
    func didTapBackButton(_ controller: ItemDetailViewController)
    func didTapShowMeDirectionsButton(_ controller: ItemDetailViewController, with coordinates: [Double])
    func viewDidAppearCalled(_ controller: ItemDetailViewController, viewModel: ItemViewModel)
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
    @IBOutlet weak var websiteUrlTextView: UITextView! {
        didSet {
            websiteUrlTextView.textContainer.lineFragmentPadding = 0
            websiteUrlTextView.textContainerInset = .zero
            websiteUrlTextView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: 34/255, green: 81/255, blue: 107/255, alpha: 1)]
        }
    }
    @IBOutlet weak var phoneNumberLabel: UILabel! {
        didSet {
            let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(phoneNumberTapped))
            phoneNumberLabel.isUserInteractionEnabled = true
            phoneNumberLabel.addGestureRecognizer(gestureRecogniser)
        }
    }
    
    @objc func phoneNumberTapped() {
        if let number = phoneNumberLabel.text, let url = URL(string: "tel://" + number) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var verticalScrollView: UIScrollView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var imagesStackView: UIStackView!
    weak var delegate: ItemDetailViewControllerDelegate?
    private var coordinates: [Double]?
    private var viewModel: ItemViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let viewModel = viewModel else { return }
        delegate?.viewDidAppearCalled(self, viewModel: viewModel)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verticalScrollView.contentInsetAdjustmentBehavior = .never
        verticalScrollView.contentInset = UIEdgeInsets(top: view.frame.width, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imagesStackView.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    func update(with viewModel: ItemViewModel) {
        self.viewModel = viewModel
        
        coordinates = viewModel.coordinates
        
        nameLabel.text = viewModel.name
        shortSummaryLabel.text = viewModel.shortSummary
        phoneNumberLabel.text = viewModel.phoneNumber
        descriptionLabel.text = viewModel.description
        websiteUrlTextView.text = viewModel.websiteUrl?.absoluteString
        
        viewModel.imageUrls?.forEach {
            let networkUIImageView = NetworkUIImageView()
            networkUIImageView.loadImage(from: $0)
            networkUIImageView.contentMode = .scaleAspectFill
            networkUIImageView.clipsToBounds = true
            networkUIImageView.translatesAutoresizingMaskIntoConstraints = false
            imagesStackView.addArrangedSubview(networkUIImageView)
        }
        imagesStackView.arrangedSubviews.first?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func updateLocation(with viewModel: ItemViewModel) {
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.latitude, longitude: viewModel.longitude, zoom: 16.0)
        let map = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
        
        self.mapView.addSubview(map)
        marker.map = map
    }
}
