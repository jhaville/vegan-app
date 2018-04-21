import Foundation

struct Item {
  let name: String
  let location: String
  let coordinates: Coordinates
  let imageUrls: [URL]?
  let websiteUrl: URL?
  let itemType: ItemType
}

enum ItemType {
  case restaurant
  case shop
  
  func toCollectionName() -> String {
    switch self {
    case .restaurant:
      return "restaurants"
    case .shop:
      return "shops"
    }
  }
}

struct Coordinates {
  let longitude: Double
  let latitude: Double
}
