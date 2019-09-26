//
//  CartViewController.swift
//  ShopWithMe
//
//  Created by Kushani Jayawardana on 9/25/19.
//  Copyright © 2019 Kushani Jayawardane. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {


    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var QtyLbl: UILabel!
 
    @IBOutlet weak var accNoText: UITextField!
    @IBOutlet weak var totLbl: UILabel!
    
    @IBAction func checkOut_Tapped(_ sender: Any) {
        let alert = UIAlertController(title: "Successful!", message: "Purchased Successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Val_Changed(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            
            accNoText.isEnabled = false
            accNoText.isUserInteractionEnabled = false
        }
        if (sender as AnyObject).selectedSegmentIndex == 1 {
            
            accNoText.isEnabled = true
            accNoText.isUserInteractionEnabled = true
        
        }
    }
    
    @IBOutlet weak var stepper: UIStepper!
    var v = 0.00;
    var v2 = 0.00;
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
        v = Double(priceDo!)
        v2 = Double(priceDo2!) // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CartViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func Stepper_Changed(_ sender: UIStepper) {
        QtyLbl.text = Int(sender.value).description
        
//        let pr = v * Double(sender.value)
        priceLbl.text = (Double(sender.value) * v).description
        totLbl.text = (Double(sender.value) * v2).description
    }
  
    var priceDo: Double? {
        if let value = priceLbl.text ?? nil {
            return Double(value)
        }
        return 0
    }
    
    var priceDo2: Double? {
        if let value = totLbl.text ?? nil {
            return Double(value)
        }
        return 0
    }
    


}
