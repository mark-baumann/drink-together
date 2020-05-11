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
    var locationManager = CLLocationManager()
    
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
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }else {
            //
        }
            
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
}

extension home: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //
    }
    
    
}
