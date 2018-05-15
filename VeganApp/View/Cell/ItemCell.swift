import UIKit

class ItemCell: UITableViewCell {
  
  static var cellIdentifier: String {
    return "\(self)"
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var backgroundImageView: NetworkUIImageView!

  func update(with itemViewModel: ItemViewModel) {
    nameLabel.text = itemViewModel.name
    locationLabel.text = itemViewModel.location
    if let backgroundImageUrl = itemViewModel.imageUrls?.first {
        self.backgroundImageView.loadImage(from: backgroundImageUrl)
    }
  }
}
