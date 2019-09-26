//
//  ItemViewController.swift
//  ShopWithMe
//
//  Created by Kushani Jayawardana on 9/24/19.
//  Copyright © 2019 Kushani Jayawardane. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var priceTxt: UILabel!
    @IBOutlet weak var nameText: UILabel!
    var previousVC = homeBuy()
    var selected : Item?
    var nameIt = ""
    var price = ""
    @IBAction func AddToCartBtn_Tapped(_ sender: Any) {
        self.nameIt = nameText.text!
        self.price = priceTxt.text!
        
        performSegue(withIdentifier: "AddtoCart", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! CartViewController
        vc.nm = self.nameIt
        vc.prz = self.price
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selected?.name)
        print(selected?.desc)
        print(selected?.price)
        print(selected?.img! as Any)

        nameText.text = selected?.name
        descText.text = selected?.desc
        
        
        if let amount = selected?.price {
            
            let am = String(amount)
            priceTxt.text = am
            
        }
        
        if selected?.img == nil {
            print("nil img")
            
        }
        else{
           
            img?.image = UIImage(data: (selected?.img!)!)
        }

        // Do any additional setup after loading the view.
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
