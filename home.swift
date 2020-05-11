//
//  home.swift
//  drink-together
//
//  Created by Mark Baumann on 08.05.20.
//  Copyright © 2020 Mark Baumann. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class home: UIViewController {

    
    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    var menuout = false
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
        menuTapped(false)
        // Do any additional setup after loading the view.
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
   
    @IBAction func menuTapped(_ sender: Any) {
        
        if menuout == false {
            leading.constant = 150
            trailing.constant = -150
            menuout = true
            button.isHidden = false
        }else {
            leading.constant = 0
            trailing.constant = 0
            menuout = false
            button.isHidden = true
        }
    }
    
    func CenterViewOnLocationManager() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
            }
    }
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }else {
            //
        }
            
    }
    
   func checkLocationAuthorization() {
       switch CLLocationManager.authorizationStatus() {
       case .authorizedWhenInUse:
           MapView.showsUserLocation = true
           CenterViewOnLocationManager()
           locationManager.startUpdatingLocation()
           break
       case .denied:
           // Show alert instructing them how to turn on permissions
           break
       case .notDetermined:
           locationManager.requestWhenInUseAuthorization()
       case .restricted:
           // Show an alert letting them know what's up
           break
       case .authorizedAlways:
           break
       }
   }
    
}

extension home: CLLocationManagerDelegate {

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
    MapView.setRegion(region, animated: true)
}


func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    checkLocationAuthorization()
}
    
    
}
