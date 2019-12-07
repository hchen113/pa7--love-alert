import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import GeoFire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var top_text: UILabel!
    @IBOutlet weak var map: MKMapView!
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    var geoFireRef: DatabaseReference?
    var geoFire: GeoFire?
    
    @IBAction func heart_clicked(_ sender: Any) {
        
        let userKey = UIDevice.current.identifierForVendor?.uuidString
        let currentLocation = locationManager.location
        geoFire!.setLocation(CLLocation(latitude: (currentLocation?.coordinate.latitude)! , longitude: (currentLocation?.coordinate.longitude)!), forKey: userKey!)
        
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
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true;
        map.userTrackingMode = .follow
        top_text.isHidden = true;
        
        let geoFireRef = Database.database().reference()
        let geoFire = GeoFire(firebaseRef: geoFireRef)
        
        
        
    }


}

