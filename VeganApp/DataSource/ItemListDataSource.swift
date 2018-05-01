import UIKit

protocol ItemListDataSourceDelegate: class {
  func didSelect(_ dataSource: ItemListDataSource, itemViewModel: ItemViewModel)
}

class ItemListDataSource: NSObject {
  var itemsViewModel: ItemsViewModel?
  weak var delegate: ItemListDataSourceDelegate?
}

extension ItemListDataSource: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemCell = tableView.dequeueReusableCell(withIdentifier: ItemCell.cellIdentifier, for: indexPath) as! ItemCell
    itemCell.selectionStyle = .none
    if let itemViewModels = itemsViewModel?.itemViewModels {
      itemCell.update(with: itemViewModels[indexPath.row])
    }
    return itemCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsViewModel?.itemViewModels.count ?? 0
  }
}

extension ItemListDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let itemsViewModel = itemsViewModel {
      delegate?.didSelect(self, itemViewModel: itemsViewModel.itemViewModels[indexPath.row])
    }
  }
}