import Foundation

struct ItemsViewModel {
  let itemViewModels: [ItemViewModel]
  let hasMore: Bool
  let indexPathsToAdd: [IndexPath]
  let isFromFirstRequest: Bool
}

extension ItemsViewModel {
  init(with items: [Item], hasMore: Bool, indexPathsToAdd: [IndexPath] = [], isFromFirstRequest: Bool) {
    self.init(itemViewModels: items.map(ItemViewModel.init), hasMore: hasMore, indexPathsToAdd: indexPathsToAdd, isFromFirstRequest: isFromFirstRequest)
  }
}

struct ItemViewModel {
  let name: String
  let locationName: String
  let distanceDescription: String
  let imageUrls: [URL]?
  let shortSummary: String
  let description: String
  let phoneNumber: String
  let websiteUrl: URL?
  let coordinates: [Double]
  let itemType: ItemType
  let tags: [Tag]?
  var latitude: Double {
    return coordinates.safeElement(at: 0) ?? 0
  }
  var longitude: Double {
    return coordinates.safeElement(at: 1) ?? 0
  }
}

extension ItemViewModel {
  init(with item: Item) {
    //mongodb = long, lat so reverse them to get 'google' order of lat, long
    let latitude = item.location?.coordinates.safeElement(at: 1) ?? 0
    let longitude = item.location?.coordinates.safeElement(at: 0) ?? 0
    self.init(name: item.name, locationName: item.locationName ?? "", distanceDescription: item.distanceDescription, imageUrls: item.imageUrls, shortSummary: item.shortSummary, description: item.description, phoneNumber: item.phoneNumber ?? "", websiteUrl: item.websiteUrl, coordinates: [latitude, longitude], itemType: item.itemType, tags: item.tags)
  }
}

extension Item {
  var distanceDescription: String {
    guard let distanceFrom = distanceFrom else { return "" }
    let roundingBehavior: NSDecimalNumberHandler = NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    let roundedNumber = NSDecimalNumber(value: distanceFrom).rounding(accordingToBehavior: roundingBehavior)
    return "\(roundedNumber) miles away"
  }
}   
