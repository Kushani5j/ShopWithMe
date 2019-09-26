//
//  ViewController.swift
//  ShopWithMe
//
//  Created by Kushani Jayawardane on 9/9/19.
//  Copyright © 2019 Kushani Jayawardane. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var isSeller: Bool = false
    
    @IBOutlet weak var roleBtn: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        
        self.showViewController()
        let urlString = "https://reqres.in/api/login"
    
        Alamofire.request(urlString,
                          method: .post,
                          parameters: ["email":"eve.holt@reqres.in","password": "cityslicka"],
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .success:
                                print("------------------")
                                print(response)
                                
//                                self.showViewController()
                                
                                break
                            case .failure(let error):
                                
                                print(error)
                            }
        }
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        let urlString = "https://reqres.in/api/register"
        
        Alamofire.request(urlString,
                          method: .post,
                          parameters: ["email":"eve.holt@reqres.in","password": "cityslicka"],
                          encoding: JSONEncoding.default,
                          headers: nil).responseJSON {
                            response in
                            switch response.result {
                            case .success:
                                break
                            case .failure(let error):
                                
                                print(error) 
                            }
        }
    }
    
    func showViewController() {
        if self.isSeller {
            performSegue(withIdentifier: "sellerSegue", sender: self)
        } else {
            performSegue(withIdentifier: "buyerSegue", sender: self)
        }
    }
    
    
    
    
    @IBAction func btnOption(_ sender: Any) {
        
        let opt = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Selling", style: .default) { (action) in
            self.isSeller = true
        }
        opt.addAction(action1)
        let action2 = UIAlertAction(title: "Buying", style: .default
        
        ) { (action) in
            self.isSeller = false
        }
        opt.addAction(action2)
        present(opt, animated: true, completion: nil)
        
    
    
        func viewDidLoad() {
        super.viewDidLoad()
        roleBtn.layer.cornerRadius = 5
        signInBtn.layer.cornerRadius = 5
        signUpBtn.layer.cornerRadius = 5
            // Do any additional setup after loading the view, typically from a nib.
    }
       
}
}

