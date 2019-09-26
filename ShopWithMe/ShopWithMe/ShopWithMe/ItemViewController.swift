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
    
    @IBAction func AddToCartBtn_Tapped(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.text = selected?.name
        descText.text = selected?.desc
        //priceTxt.text = String(selected?.price) + "0"
        if selected?.img == nil {
            print("img is nil")
            
        }
        else{
            let im: UIImage = UIImage(data: selected?.img as! Data)!
            img.image = im
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
