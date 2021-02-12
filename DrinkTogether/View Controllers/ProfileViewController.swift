//
//  ProfileViewController.swift
//  DrinkTogether
//
//  Created by Mark Baumann on 12.02.21.
//

import UIKit
import FirebaseStorage
import FirebaseCore
import FirebaseDatabase
import SDWebImage
import FirebaseUI

class ProfileViewController: UIViewController {

    

    
    
    @IBOutlet weak var imageView: UIImageView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
            downloadImages()
       
    
        
        
    }
    
   
    
    func downloadImages() {
        
        let storageRef = Storage.storage().reference()
        let localURL = URL(string: "images/file.png")!
        
        
        
        
        // Reference to an image file in Firebase Storage
        let reference = storageRef.child("images/file.png")

        // UIImageView in your ViewController
        let imageView: UIImageView = self.imageView

        // Placeholder image
        let placeholderImage = UIImage(named: "placeholder.jpg")

        // Load the image using SDWebImage
        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
        
        
        
        
        // Create a reference to the file we want to download
        let starsRef = storageRef.child("images/file.png")

        // Start the download (in this case writing to a file)
        let downloadTask = storageRef.write(toFile: localURL)

        // Observe changes in status
        downloadTask.observe(.resume) { snapshot in
          // Download resumed, also fires when the download starts
        }

        downloadTask.observe(.pause) { snapshot in
          // Download paused
        }

        downloadTask.observe(.progress) { snapshot in
          // Download reported progress
          let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        }

        downloadTask.observe(.success) { snapshot in
          // Download completed successfully
        }
    }
    
   
    
    
    
    

}
