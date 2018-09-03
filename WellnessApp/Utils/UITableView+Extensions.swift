import UIKit

extension UITableView {
  func setLoading() {
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    addSubview(activityIndicatorView)

    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    activityIndicatorView.widthAnchor.constraint(equalToConstant: 25).isActive = true
    activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    activityIndicatorView.startAnimating()
  }
  
  func stopLoading() {
    subviews.filter { $0 is UIActivityIndicatorView }.first?.removeFromSuperview()
  }
}
