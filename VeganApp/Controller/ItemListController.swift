import UIKit

enum ViewControllerState {
  case loading
  case error
  case `default`
}

protocol Stateful {
  func setState(to state: ViewControllerState)
  func showLoadingState()
  func showErrorState()
  func showDefaultState()
}

class ItemListController: UIViewController, Stateful {

  var listItemType: ItemListType?
  var items = [Item]() {
    didSet {
      tableView.reloadData()
    }
  }
    
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: ItemCell.cellIdentifier)
      tableView.estimatedRowHeight = 66.0
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.separatorStyle = .none
      tableView.allowsSelection = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func setState(to state: ViewControllerState) {
    switch state {
    case .loading:
      showLoadingState()
    case .error:
      showErrorState()
    case .default:
      showDefaultState()
    }
  }
  
  func showLoadingState() {
    tableView.setLoading()
  }
  
  func showErrorState() { }
  
  func showDefaultState() {
    tableView.stopLoading()
  }
  
}

extension ItemListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemCell = tableView.dequeueReusableCell(withIdentifier: ItemCell.cellIdentifier, for: indexPath) as! ItemCell
    itemCell.nameLabel.text = items[indexPath.row].name
    itemCell.locationLabel.text = items[indexPath.row].location

    return itemCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
}


extension UITableView {
  func setLoading() {
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    addSubview(activityIndicatorView)
    activityIndicatorView.center = center
    activityIndicatorView.startAnimating()
  }
  
  func stopLoading() {
    let activityIndicatorView = subviews.filter { $0 is UIActivityIndicatorView }.first
    activityIndicatorView?.removeFromSuperview()
  }
}

