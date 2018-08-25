import UIKit

final class NetworkUIImageView: UIImageView {
  
  private static let imageCache = NSCache<NSString, UIImage>()
  private var currentUrl: URL?
  
  func loadImage(from url: URL) {
    image = nil
    
    if let imageFromCache = NetworkUIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
      image = imageFromCache
      return
    }
    
    self.currentUrl = url
    backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil else { return }
      guard self.currentUrl == url, let data = data, let image = UIImage(data: data) else { return }
      NetworkUIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
      DispatchQueue.main.async {
        self.image = image
      }
      }.resume()
  }
}
