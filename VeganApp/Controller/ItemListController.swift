import UIKit

enum ViewState<A> {
  case loading
  case error(Error?)
  case data(A)
}

class ItemListController: UIViewController {

  var itemType: ItemType?
  private var itemViewModels = [ItemViewModel]()
    
  @IBOutlet weak var errorView: UIView!
  @IBOutlet weak var errorViewLabel: UILabel!
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
  
  func update(with viewState: ViewState<ItemsViewModel>) {
    resetState()
    switch viewState {
    case .loading:
      showLoadingState()
    case .error(let error):
      showErrorState(with: error)
    case .data(let itemsViewModel):
      if itemsViewModel.itemViewModels.isEmpty { showErrorState(with: nil, isEmpty: true) } else { update(with: itemsViewModel) }
    }
  }
  
  private func resetState() {
    errorView.isHidden = true
    tableView.stopLoading()
  }
  
  func update(with viewModel: ItemsViewModel) {
    itemViewModels = viewModel.itemViewModels
    tableView.reloadData()
  }
  
  func showLoadingState() {
    tableView.setLoading()
  }
  
  func showErrorState(with error: Error?, isEmpty: Bool = false) {
    errorView.isHidden = false
    if let error = error {
      errorViewLabel.text = error.localizedDescription
    } else if isEmpty {
      showEmptyState()
    }
  }
  
  func showEmptyState() {
    errorViewLabel.text = "There are currently no \((itemType ?? .restaurant).toCollectionName()) near you, please check back later"
  }
}

extension ItemListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemCell = tableView.dequeueReusableCell(withIdentifier: ItemCell.cellIdentifier, for: indexPath) as! ItemCell
    itemCell.update(with: itemViewModels[indexPath.row])
    return itemCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemViewModels.count
  }
}
