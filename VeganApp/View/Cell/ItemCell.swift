import UIKit

class ItemCell: UITableViewCell {
  
  static var cellIdentifier: String {
    return "\(self)"
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
}
