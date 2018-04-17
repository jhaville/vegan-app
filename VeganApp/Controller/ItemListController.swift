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
  
  let loadingOverlay = LoadingOverlay()
  var listItemType: ItemListType?
    
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: ItemCell.cellIdentifier)
      tableView.estimatedRowHeight = 66.0
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.separatorStyle = .none
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
    loadingOverlay.show()
  }
  
  func showErrorState() {
    
  }
  
  func showDefaultState() {
    loadingOverlay.hide()
  }
  
}

extension ItemListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemCell = tableView.dequeueReusableCell(withIdentifier: ItemCell.cellIdentifier, for: indexPath)
    return itemCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
}




