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

    
    
    let manager = CLLocationManager()
    
    
    private let topstack = HomeNavigationStackView()
    
    private let bottomstack = BottomControlsStackView()
    
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        configureCards()
    }

    
    func configureCards() {
        
        let user1 = User(name: "penis", age: 22, images: [#imageLiteral(resourceName: "lady5c"), #imageLiteral(resourceName: "kelly1")])
        let user2 = User(name: "Megan Fox", age: 23, images: [#imageLiteral(resourceName: "kelly2"), #imageLiteral(resourceName: "kelly1")])
        
        let CardView1 = CardView(viewModel: CardViewModel(user: user1))
        let CardView2 = CardView(viewModel: CardViewModel(user: user2))
        
       
        
        deckView.addSubview(CardView1)
        deckView.addSubview(CardView2)
        
        
        CardView1.fillSuperview()
        CardView2.fillSuperview()
    }
    

    func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topstack, deckView, bottomstack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
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
            CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
          
            
            
            
            
            
            
            
           
            let userID = Auth.auth().currentUser?.uid ?? "x"
            Firestore.firestore().collection("users").whereField("uid", isEqualTo: userID)
                    
                    
                
            
            
                           let geofireRef = Database.database().reference()
                           let geoFire = GeoFire(firebaseRef: geofireRef)
                       
                       
                       
                       
                       
            geoFire.setLocation(CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), forKey: userID)
                     
                    
                       let centerQuery = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                       let circleQuery = geoFire.query(at: centerQuery, withRadius: 5)
                        
                
            var queryHandle = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
                
                
                
                
                                
            })
                
                
                
               
                
                
            }
                        
                        
                                   
                                       
                                    
                        
                }
            
            
    
        
       }

    
    

    




      
           



