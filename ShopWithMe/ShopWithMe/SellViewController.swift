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

class SellViewController: UIViewController, CLLocationManagerDelegate,UIImagePickerControllerDelegate{

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
        
        view.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var locationText: UITextField!
    
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var locText: UITextField!
    
    @IBOutlet weak var qtyText: UITextField!
    @IBAction func AddItemBtnTapped(_ sender: UIButton) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let toDo = Item(context: context )
            
            if let titleText = titleTextField.text {
                toDo.name = titleText
                toDo.desc = desc.text
                toDo.price = priceDo!
                toDo.qty = qtyDo!
//                toDo.img =  (imgView?.image)!.pngData()
                toDo.location = locText.text
            }
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }
    
    var qtyDo: Int32? {
        if let value = qtyText.text ?? nil {
            return Int32(value)
        }
        return 0
    }
    
    var priceDo: Double? {
        if let value = priceText.text ?? nil {
            return Double(value)
        }
        return 0
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
        imgView.image = image
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
//        print("Longitude: " + String(loc.coordinate.longitude))
        CLGeocoder().reverseGeocodeLocation(loc) { (MKPlacemark, error) in
            if error != nil
            {
                self.locationText.text = "Enter item location"
            }
        
            else
            {
                if let place = MKPlacemark?[0]
                {
                    var locate="\(String(describing: place.thoroughfare)) " + "\(String(describing: place.subThoroughfare))" + "\(String(describing: place.country))"
                    locate = locate.replacingOccurrences(of: "Optional", with: "").replacingOccurrences(of: "nilOptional", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: ")", with: "/")
//                    print(locate)
                    self.locationText.text = locate
                    
                   
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
    
}
