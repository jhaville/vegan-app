import UIKit

enum ViewState<A> {
  case loading
  case error(Error?)
  case data(A)
}

protocol ItemListControllerDelegate: class {
  func didSelect(_ viewController: ItemListController, itemViewModel: ItemViewModel)
}

class ItemListController: UIViewController {

  var itemType: ItemType?
  private let itemListDataSource = ItemListDataSource()
  private let refreshControl = UIRefreshControl()
  weak var delegate: ItemListControllerDelegate?
  @IBOutlet weak var errorView: UIView!
  @IBOutlet weak var errorViewLabel: UILabel!
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = itemListDataSource
      tableView.delegate = itemListDataSource
      tableView.refreshControl = refreshControl
      refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
      itemListDataSource.delegate = self
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

  @objc private func refresh() {
    print("refresh")
    refreshControl.beginRefreshing()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
        self.refreshControl.endRefreshing()
    }
  }
  
  func update(with viewState: ViewState<ItemsViewModel>) {
    resetState()
    switch viewState {
    case .loading:
      showLoadingState()
    case .error(let error):
      showErrorState(with: error)
    case .data(let itemsViewModel):
      if itemsViewModel.itemViewModels.isEmpty {
        showErrorState(with: nil, isEmpty: true)
      } else {
        update(with: itemsViewModel)
      }
    }
  }
  private func update(with viewModel: ItemsViewModel) {
    itemListDataSource.itemsViewModel = viewModel
    tableView.reloadData()
  }

  private func resetState() {
    errorView.isHidden = true
    tableView.stopLoading()
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

extension ItemListController: ItemListDataSourceDelegate {
  func didSelect(_ dataSource: ItemListDataSource, itemViewModel: ItemViewModel) {
    delegate?.didSelect(self, itemViewModel: itemViewModel)
  }
}
