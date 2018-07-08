import UIKit

extension UIViewController
{
  static func load<T: UIViewController>(_ type: T.Type) -> T
  {
    guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(T.self)") as? T else {
      fatalError()
    }
    return viewController
  }
}
