import UIKit

class ItemCell: UITableViewCell {
  
  static var cellIdentifier: String {
    return "\(self)"
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  func update(with itemViewModel: ItemViewModel) {
    nameLabel.text = itemViewModel.name
    locationLabel.text = itemViewModel.location
    
  }
}
