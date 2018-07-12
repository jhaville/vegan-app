import UIKit

class ItemCell: UITableViewCell {
  static var cellIdentifier: String {
    return "\(self)"
  }

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var backgroundImageView: NetworkUIImageView!
  @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var tagsStackView: UIStackView!
    func update(with itemViewModel: ItemViewModel) {
    nameLabel.text = itemViewModel.name
    locationLabel.text = itemViewModel.locationName
    distanceLabel.text = itemViewModel.distanceDescription
    if let backgroundImageUrl = itemViewModel.imageUrls?.first {
      self.backgroundImageView.loadImage(from: backgroundImageUrl)
    }
    itemViewModel.tags?.forEach {
        tagsStackView.addArrangedSubview(TagView(with: $0))
    }
    tagsStackView.widthAnchor.constraint(equalToConstant: CGFloat((itemViewModel.tags?.count ?? 0) * 40 + 5)).isActive = true
  }
}

final class TagView: UIView {
  let label = UILabel()
  init(with tag: Tag) {
    super.init(frame: .zero)
    setupViews(with: tag)
    setupHierarchy()
    setupLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews(with tag: Tag) {
    backgroundColor = tag.toColor()
    label.text = tag.toShortName()
    translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    layer.cornerRadius = 20
  }

  private func setupHierarchy() {
    addSubview(label)
  }

  private func setupLayout() {
    widthAnchor.constraint(equalToConstant: 40).isActive = true
    heightAnchor.constraint(equalToConstant: 40).isActive = true
    label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
}
