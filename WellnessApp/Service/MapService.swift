import UIKit

class MapService {
  func showDirectionsWithGoogleMaps(to coordinates: [Double]) {

    guard let baseAppUrl = URL(string: GoogleMapConstants.baseAppUrlString),
    let latitude = coordinates.safeElement(at: 0), let longitude = coordinates.safeElement(at: 1),
    let appUrl = URL(string: GoogleMapConstants.baseAppUrlString + "?daddr=\(latitude),\(longitude)&directionsmode=walking"),
    let webUrl = URL(string: GoogleMapConstants.baseWebUrlString + "maps/dir/?daddr=\(latitude),\(longitude)&directionsmode=walking")
    else { return }

    if UIApplication.shared.canOpenURL(baseAppUrl) {
        UIApplication.shared.open(appUrl, options:[:], completionHandler: nil)
    } else {
      UIApplication.shared.open(webUrl)
    }
  }
}

struct GoogleMapConstants {
    static let baseAppUrlString = "comgooglemaps://"
    static let baseWebUrlString = "https://www.google.com/"
}
