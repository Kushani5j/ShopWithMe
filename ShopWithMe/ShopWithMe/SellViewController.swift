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
import CoreData

class SellViewController: UIViewController, CLLocationManagerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var addPhotoBtn: UIButton!
    
    let mngr = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        mngr.delegate = self
        mngr.desiredAccuracy = kCLLocationAccuracyBest
        mngr.requestWhenInUseAuthorization()
        mngr.startUpdatingLocation()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SellViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        priceText.keyboardType = .asciiCapableNumberPad
        qtyText.keyboardType = .asciiCapableNumberPad
    }

    
    @IBOutlet weak var map: MKMapView!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationText: UITextField!
    
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var locText: UITextField!
    
    @IBOutlet weak var qtyText: UITextField!
    
    var itemImage: UIImage?
    var latitude: Double?
    var longitude: Double?
  
    @IBAction func AddItemBtnTapped(_ sender: UIButton) {

        if  !self.titleTextField.text!.isEmpty && !self.priceText.text!.isEmpty && !self.qtyText.text!.isEmpty && !self.desc.text!.isEmpty && !self.imageView.image!.isProxy() && !self.locationText.text!.isEmpty
        {
            var imageData: Data?
            
            print("image!!!!!!")
            
            if let itemImage = itemImage {
                imageData = itemImage.jpegData(compressionQuality: 0.5)
            }
            
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
            
            let items = Item(entity: entity!, insertInto: context)
            items.name = titleTextField.text
            items.price = Double(priceText.text!)!
            items.desc = desc.text
            items.location = locationText.text
            items.img = imageData  
            items.qty = Int32(qtyText.text!)!
            items.latitude = latitude!
            items.longitude = longitude!
            
            try!  context.save()
            
            titleTextField.text = ""
            priceText.text = ""
            priceText.text = ""
            qtyText.text = ""
            desc.text = ""
            imageView.image = nil
        }
            
        else{
            let alert = UIAlertController(title: "Warning!", message: "Fill empty fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)        }
    }
    


    
    @IBAction func AddPhotoBtn_Tapped(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage
            else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = image
        self.itemImage = image
        print("img save")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 1.01, longitudeDelta: 0.01)
        
        let myLoc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
        let reg:MKCoordinateRegion = MKCoordinateRegion(center: myLoc, span: span)
        
        map.setRegion(reg, animated: true)
        self.map.showsUserLocation = true
        self.latitude = loc.coordinate.latitude
        self.longitude = loc.coordinate.longitude
        
//        print("Longitude: " + String(loc.coordinate.longitude))
        CLGeocoder().reverseGeocodeLocation(loc) { (MKPlacemark, error) in
            if error != nil
            {
                self.locationText.text = "Enter item location"
            }
        
            else
            {
                if let place = MKPlacemark?[0]
                {   var locate="\(String(describing: place.thoroughfare)) " + "\(String(describing: place.subThoroughfare))" + "\(String(describing: place.country))"
                    locate = locate.replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "nilOptional", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: ")", with: "/")
//                    print(locate)
                    self.locationText.text = locate
                    
                   
                }
        
    }

}
    }
    
}
