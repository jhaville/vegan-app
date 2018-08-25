import UIKit

final class LocationPermissionDeniedViewController: UIViewController {
  
  @IBAction func tappedGoToDeviceSettings(_ sender: Any) {
    UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
  }
}
