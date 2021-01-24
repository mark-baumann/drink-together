//
//  HomeViewController.swift
//  DrinkTogether
//
//  Created by Nikolas Obser on 02.12.20.
//

import UIKit
import Firebase
import FirebaseAuth
import MapKit
import CoreLocation


class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startUserFetching()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest //wie genau der Standort abgerufen wird
        manager.startUpdatingLocation() //Standort holen
    }
    
    func startUserFetching() {
        /** Startet einen Hintergrund thread der alle paar Sekunden die User in den nächsten 5 Kilometern holt */
        
        // TODO thread loop
        fetchNearUsers()
    }
    
    
    func fetchNearUsers() {
        
        /*
        // ~1 mile of lat and lon in degrees
        let lat = 0.0144927536231884
        let lon = 0.0181818181818182
        
        var latitude: Double? = nil
        var longitude: Double? = nil
        
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "x")
            .getDocuments { (querySnapshot, err) in
                if err != nil {
                    return
                }

                let docdata: [String: Any] = querySnapshot!.documents[0].data()
                
                if docdata["koordinaten"] == nil {
                    return
                }
                
                let koords: GeoPoint = docdata["koordinaten"] as! GeoPoint
                
                latitude = koords.latitude
                longitude = koords.longitude
                
                //latitude = koords[0] as? Double
                //longitude = koords[1] as? Double
        }
 */
    
        /*
        print("NOBBISCHER latitude: ", latitude)
        print("NOBBISCHER longitude: ", longitude)
        
        
     
        let latitude
        
        let lowerLat = latitude - (lat * distance)
        let lowerLon = longitude - (lon * distance)

        let greaterLat = latitude + (lat * distance)
        let greaterLon = longitude + (lon * distance)

        let lesserGeopoint = GeoPoint(latitude: lowerLat, longitude: lowerLon)
        let greaterGeopoint = GeoPoint(latitude: greaterLat, longitude: greaterLon)

        let docRef = Firestore.firestore().collection("locations")
        let query = docRef.whereField("location", isGreaterThan: lesserGeopoint).whereField("location", isLessThan: greaterGeopoint)

        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
 */
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let db = Firestore.firestore()
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.MapView.setRegion(region, animated: true)
            
            
            
            
            let newPin = MKPointAnnotation()
            newPin.coordinate = location.coordinate
            MapView.addAnnotation(newPin)
            
            
            
            
            db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "x")
                .getDocuments { (querySnapshot, err) in
                    if err != nil {
                        print("Failed")
                        return
                    }

                    let  userdocid = querySnapshot!.documents[0].documentID
                    db.collection("users").document(userdocid).setData(["koordinaten" : [GeoPoint(latitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude))]],merge: true)
                    
                    
                    
                   
                 
                }
            
            
    
        
        }

}
}



      
           
