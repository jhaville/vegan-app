import Foundation

struct Item {
  let name: String
  let location: String
  let coordinates: Coordinates
  let imageUrls: [URL]
  let websiteUrl: URL
  let itemType: ItemType
}

enum ItemType {
  case restaurant
  case shop
}

struct Coordinates {
  let longitude: Double
  let latitude: Double
}
