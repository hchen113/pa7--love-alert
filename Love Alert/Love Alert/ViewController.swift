import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import GeoFire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    //-----------------------------------------------------------------------------
    //REFERENCE TO: https://firebaseopensource.com/projects/firebase/geofire-objc/
    //-----------------------------------------------------------------------------
    
    
    @IBOutlet weak var top_text: UILabel!
    @IBOutlet weak var map: MKMapView!
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    let geofireRef = Database.database().reference()
    var userKey = UIDevice.current.identifierForVendor!.uuidString
    
    
    @IBAction func heart_clicked(_ sender: Any) {
        let geoFire = GeoFire(firebaseRef: geofireRef)
        let currentLocation = locationManager.location
        let userKey = UIDevice.current.identifierForVendor!.uuidString
        geoFire.setLocation(CLLocation(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!), forKey: userKey) { (error) in
          if (error != nil) {
            print("An error occured: \(String(describing: error))")
          } else {
            print("Saved location successfully!")
          }
        }
            
        top_text.text = "You've just liked someone around you!"
        top_text.isHidden = false;
        _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.top_text.isHidden = true;
        }
        _ = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { (timer) in
            geoFire.removeKey(userKey)
            print("Removed location data.")
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

        map.showsUserLocation = true
        map.userTrackingMode = .follow
        top_text.isHidden = true
        notify()
    }
    
    
    
    func notify(){
        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            print("Starting Notify()")
            let geofireRef = Database.database().reference()
            let geoFire = GeoFire(firebaseRef: geofireRef)
            let currentLocation = self.locationManager.location
            //let center = CLLocation(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.latitude)!)
            let circleQuery = geoFire.query(at: currentLocation!, withRadius: 0.1)
            _ = circleQuery.observe(.keyEntered, with: { (key: String?, location: CLLocation?) in
                geoFire.getLocationForKey(key!) { (location, error) in
                  if (error != nil) {
                    print("An error occurred getting the location for Key")
                  } else if (location != nil) {
                    print("Location for \"firebase-hq\" is [\(location!.coordinate.latitude), \(location!.coordinate.longitude)]")
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location!.coordinate
                    self.map.addAnnotation(annotation)
                  } else {
                    print("GeoFire does not contain a location for \"firebase-hq\"")
                  }
                }
                
                self.top_text.text = "Someone around you just liked someone!"
                self.top_text.isHidden = false;
                _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
                    self.top_text.isHidden = true;
                }
            })
            _ = circleQuery.observeReady({
                   print("  All initial data has been loaded and events have been fired!")
               })

        }
    }


    
    
    
    
    
    
}

