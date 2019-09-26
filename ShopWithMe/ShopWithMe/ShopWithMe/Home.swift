//
//  home.swift
//  ShopWithMe
//
//  Created by Kushani Jayawardane on 9/9/19.
//  Copyright © 2019 Kushani Jayawardane. All rights reserved.
//

import UIKit
import CoreData

class homeBuy: UIViewController {
    var itemList: [Item] = []
    var displayItemList: [Item] = []
    
    @IBOutlet weak var uiCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aaa")
        self.fetchData()
        //self.dlt()
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
    
    
    
    func dlt () {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Item"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
        
    }
    
    func fetchData () {
        self.itemList = []
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        request.returnsObjectsAsFaults = false
        
        let items: NSArray = try! context.fetch(request) as NSArray
        if items.count > 0 {
            for item in items {
                let item = item as! Item
                itemList.append(item)
            }
        }
        
        displayItemList = itemList
    }
    
}


extension homeBuy: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.label1.text = displayItemList[indexPath.item].name
        var pr : String?
        pr = String(displayItemList[indexPath.item].price) + "0"
        cell.label2.text = pr
        if displayItemList[indexPath.item].img == nil {
            print("img is nil")
            
        }
        else{
            let img: UIImage = UIImage(data: displayItemList[indexPath.item].img as! Data)!
            cell.image1.image = img
        }
        
        return cell
        
    }
    
  
     func collectionView(_ collectionView: UICollectionView, didSelectRowAt indexPath: IndexPath) {
        let items = displayItemList[indexPath.row].name
        print("items")
        print(items)
        performSegue(withIdentifier: "ItemView", sender: items)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let ItemVC = segue.destination as? ItemViewController {
            if let items = sender as? Item {
                ItemVC.selected = items
                ItemVC.previousVC = self
            }
        }
    }

}



extension homeBuy: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            displayItemList = itemList
        } else {
            displayItemList = itemList.filter {$0.name!.contains(searchText)}
        }
        
        self.uiCollection.reloadData()
    }
}
