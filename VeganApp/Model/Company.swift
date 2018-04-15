import Foundation

struct Company {
  let name: String
  let location: String
  let coordinates: Coordinates
  let imageUrls: [URL]
  let websiteUrl: URL
  let companyType: CompanyType
}

enum CompanyType {
  case restaurant
  case shop
}

struct Coordinates {
  let longitude: Double
  let latitude: Double
}
