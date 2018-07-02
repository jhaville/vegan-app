import Foundation
import Firebase

struct Items: Decodable {
    let items: [Item]
}

struct Item: Decodable {
  let name: String
  let shortSummary: String
  let phoneNumber: String?
  let description: String
  let locationName: String?
  let location: Location?
  let imageUrls: [URL]?
  let websiteUrl: URL?
  let itemType: ItemType
  let distanceFrom: Double?
}

struct Location: Decodable {
    let coordinates: [Double]
}

enum ItemType: String, Decodable {
  case restaurant
  case shop
  case subscription
  
  func toCollectionName() -> String {
    switch self {
    case .restaurant:
      return "restaurants"
    case .shop:
      return "shops"
    case .subscription:
      return "subscriptions"
    }
  }
}

extension Array {
    func safeElement(at index: Int) -> Element? {
        if indices.contains(index) { return self[index] }
        return nil
    }
}
