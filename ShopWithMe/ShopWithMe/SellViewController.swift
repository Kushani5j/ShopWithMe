//
//  SellViewController.swift
//  ShopWithMe
//
//  Created by Kushani Jayawardane on 9/9/19.
//  Copyright © 2019 Kushani Jayawardane. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SellViewController: UIViewController, CLLocationManagerDelegate {

    let mngr = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        mngr.delegate = self
        mngr.desiredAccuracy = kCLLocationAccuracyBest
        mngr.requestWhenInUseAuthorization()
        mngr.stopUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var locationText: UITextField!
    
    @IBAction func AddPhotoBtn_Tapped(_ sender: Any) {
        let imgPickerController = UIImagePickerController()
        
        imgPickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        imgPickerController.sourceType = .camera
        self.present(imgPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imgView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 1.01, longitudeDelta: 0.01)
        
        let myLoc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
        let reg:MKCoordinateRegion = MKCoordinateRegion(center: myLoc, span: span)
        
        map.setRegion(reg, animated: true)
        self.map.showsUserLocation = true
        
        CLGeocoder().reverseGeocodeLocation(loc) { (MKPlacemark, error) in
            if error != nil
            {
                self.locationText.text = "Enter item location"
            }
        
            else
            {
                if let place = MKPlacemark?[0]
                {
                    self.locationText.text = "\(String(describing: place.thoroughfare)) " + "\(String(describing: place.subThoroughfare))" + "\(String(describing: place.country))"
                }
            }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
