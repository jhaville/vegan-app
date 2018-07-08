import UIKit

extension UITableView {
  func setLoading() {
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    addSubview(activityIndicatorView)
    activityIndicatorView.center = center
    activityIndicatorView.startAnimating()
  }
  
  func stopLoading() {
    let activityIndicatorView = subviews.filter { $0 is UIActivityIndicatorView }.first
    activityIndicatorView?.removeFromSuperview()
  }
}
