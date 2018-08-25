import UIKit

struct Items: Decodable {
  let items: [Item]
  let cursor: Int
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

extension Item: Equatable {
  static func ==(lhs: Item, rhs: Item) -> Bool {
    return lhs.description == rhs.description &&
      lhs.distanceDescription == rhs.distanceDescription &&
      lhs.distanceFrom == rhs.distanceFrom &&
      lhs.imageUrls == rhs.imageUrls &&
      lhs.itemType == rhs.itemType &&
      lhs.location == rhs.location &&
      lhs.locationName == rhs.locationName &&
      lhs.name == rhs.name &&
      lhs.phoneNumber == rhs.phoneNumber &&
      lhs.shortSummary == rhs.shortSummary &&
      lhs.tags == rhs.tags &&
      lhs.websiteUrl == rhs.websiteUrl
  }
}

extension Location: Equatable {
  static func ==(lhs: Location, rhs: Location) -> Bool {
    return lhs.coordinates == rhs.coordinates
  }
}
