import UIKit

enum ViewState<A> {
  case loading
  case error(Error?)
  case data(A)
}

protocol ItemListControllerDelegate: class {
  func didSelect(_ viewController: ItemListController, itemViewModel: ItemViewModel)
  func didRefresh(_ viewController: ItemListController)
  func didRequestMoreItems(_ viewController: ItemListController)
}

class ItemListController: UIViewController {

  lazy var footerLoadingView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicatorView.startAnimating()
    activityIndicatorView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
    activityIndicatorView.backgroundColor = .white
    return activityIndicatorView
  }()

  
  var itemType: ItemType?
  private let itemListDataSource = ItemListDataSource()
  private let refreshControl = UIRefreshControl()
  weak var delegate: ItemListControllerDelegate?
  
  @IBOutlet weak var errorView: UIView!
  @IBAction func retryButtonTapped(_ sender: Any) {
    delegate?.didRefresh(self)
  }
  @IBOutlet weak var errorViewLabel: UILabel!
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = itemListDataSource
      tableView.delegate = itemListDataSource
      tableView.refreshControl = refreshControl
      refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
      itemListDataSource.delegate = self
      tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: ItemCell.cellIdentifier)
      tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: LoadingCell.cellIdentifier)
      tableView.estimatedRowHeight = 250
      tableView.separatorStyle = .none
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  @objc private func refresh() {
    refreshControl.beginRefreshing()
    delegate?.didRefresh(self)
  }

  func clearLoadingFooter() {
    tableView.tableFooterView = nil
  }
  
  func update(with viewState: ViewState<ItemsViewModel>, indexPaths: [IndexPath] = []) {
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
        update(with: itemsViewModel, indexPaths)
      }
    }
  }

  private func update(with viewModel: ItemsViewModel, _ indexPaths: [IndexPath]) {

    itemListDataSource.itemsViewModel = viewModel

    tableView.tableFooterView = nil
    if indexPaths.isEmpty {
      tableView.reloadData()
    } else {
      tableView.insertRows(at: indexPaths, with: .none)
    }
  }
  
  private func resetState() {
    refreshControl.endRefreshing()
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
    errorViewLabel.text = "There are currently no " + (itemType ?? .restaurant).toCollectionName() + " near you, please check back later"
  }

}

extension ItemListController: ItemListDataSourceDelegate {
  func didSelect(_ dataSource: ItemListDataSource, itemViewModel: ItemViewModel) {
    delegate?.didSelect(self, itemViewModel: itemViewModel)
  }

  func didScrollToEnd(_ dataSource: ItemListDataSource) {
    tableView.tableFooterView = footerLoadingView
    delegate?.didRequestMoreItems(self)
  }
}
