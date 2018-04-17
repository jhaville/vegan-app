import UIKit

class LoadingOverlay: UIView {
  static let sharedInstance = LoadingOverlay()
  let activitySpinner = UIActivityIndicatorView()

  func show() {
    let loadingOverlay = LoadingOverlay.sharedInstance
    loadingOverlay.isHidden = true

    guard let window = UIApplication.shared.keyWindow else { return }
    loadingOverlay.translatesAutoresizingMaskIntoConstraints = false
    activitySpinner.translatesAutoresizingMaskIntoConstraints = false

    window.addSubview(loadingOverlay)
    loadingOverlay.addSubview(activitySpinner)
    
    loadingOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    loadingOverlay.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
    loadingOverlay.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
    loadingOverlay.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
    loadingOverlay.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
    
    activitySpinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
    activitySpinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
    activitySpinner.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
    activitySpinner.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
    
    loadingOverlay.isHidden = false
    
    activitySpinner.startAnimating()
  }
  
  func hide() {
    let loadingOverlay = LoadingOverlay.sharedInstance
    loadingOverlay.isHidden = false
    loadingOverlay.removeFromSuperview()
    activitySpinner.stopAnimating()
  }
  
}
