import UIKit

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
  let tags: [Tag]?
}

struct Location: Decodable {
    let coordinates: [Double]
}

enum ItemType: String, Decodable {
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

enum Tag: String, Decodable {
    case vegan
    case vegetarian

    func toColor() -> UIColor {
        switch self {
        case .vegan:
            return .brown
        case .vegetarian:
            return UIColor(red: 55/255, green: 206/255, blue: 140/255, alpha: 1)
        }
    }

    func toShortName() -> String {
        switch self {
        case .vegan:
            return "VGN"
        case .vegetarian:
            return "VEG"
        }
    }
}

extension Array {
    func safeElement(at index: Int) -> Element? {
        if indices.contains(index) { return self[index] }
        return nil
    }
}
