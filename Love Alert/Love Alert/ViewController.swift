import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var top_text: UILabel!
    @IBOutlet weak var map: MKMapView!
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    @IBAction func heart_clicked(_ sender: Any) {
        top_text.text = "You've just liked someone around you!"
        top_text.isHidden = false;
        _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.top_text.isHidden = true;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true;
        map.userTrackingMode = .follow
        top_text.isHidden = true;
    }


}

