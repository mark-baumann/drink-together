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
import FirebaseDatabase
import GeoFire

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    
    let manager = CLLocationManager()
    
    
    @IBAction func drinkbutton(_ sender: Any) {
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

    
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest //wie genau der Standort abgerufen wird
        manager.startUpdatingLocation() //Standort holen
    }
    
    
    
    
   
    
    
    
    
    
  
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.MapView.setRegion(region, animated: true)
            
            
            
            
            let newPin = MKPointAnnotation()
            newPin.coordinate = location.coordinate
            MapView.addAnnotation(newPin)
            
            
            
            let userID = Auth.auth().currentUser?.uid ?? "x"
            Firestore.firestore().collection("users").whereField("uid", isEqualTo: userID)
                    
                    
                
            
            
                           let geofireRef = Database.database().reference()
                           let geoFire = GeoFire(firebaseRef: geofireRef)
                       
                       
                       
                       
                       
                       geoFire.setLocation(CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), forKey: userID)
                     
                    
                       let centerQuery = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                       let circleQuery = geoFire.query(at: centerQuery, withRadius: 5)
                        
                
            var queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
                let annotation = MKPointAnnotation()
                let coord = CLLocationCoordinate2D() 
                annotation.coordinate = coord
                annotation.title = "some user name"
                self.MapView.addAnnotation(annotation)
            })
                
                
                
               
                
                
            }
                        
                        
                                   
                                       
                                    
                        
                }
            
            
    
        
       }

    
    

    




      
           



