//
//  home.swift
//  ShopWithMe
//
//  Created by Kushani Jayawardane on 9/9/19.
//  Copyright © 2019 Kushani Jayawardane. All rights reserved.
//

import UIKit

class homeBuy: UIViewController {
    

    @IBOutlet weak var uiCollection: UICollectionView!
    
    let items = ["Car","House","Laptop","Phone","dog","Cupboard"]
    var displayItems = ["Car","House","Laptop","Phone","dog","Cupboard"]
    
    let price = [120000.00,5000000.00,100000.00,85000.00,25000.00,8000.00]
    
    var displayPrice = [120000.00,5000000.00,100000.00,85000.00,25000.00,8000.00]
    
    
    
    let itemImages: [UIImage] = [
        UIImage(named: "car")!,
        UIImage(named: "house")!,
        UIImage(named: "lap")!,
        UIImage(named: "phone")!,
        UIImage(named: "dog")!,
        UIImage(named: "cupboard")!
        
    ]
    
    var displayItemImages: [UIImage] = [
        UIImage(named: "car")!,
        UIImage(named: "house")!,
        UIImage(named: "lap")!,
        UIImage(named: "phone")!,
        UIImage(named: "dog")!,
        UIImage(named: "cupboard")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension homeBuy: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.label1.text = displayItems[indexPath.item]
        cell.image1.image = displayItemImages[indexPath.item]
        cell.label2.text = String(displayPrice[indexPath.item])
        return cell
        
    }
}

extension homeBuy: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            displayItems = items
            displayItemImages = itemImages
            displayPrice = price
            self.uiCollection.reloadData()
        } else {
            displayItems = items.filter {$0.contains(searchText)}
            setImagesForItems()
        }
    }
    
    func setImagesForItems() {
        for item in displayItems {
            let index = items.index(of: item)
            displayItemImages[displayItems.index(of: item)!] = itemImages[index!]
        }
        self.uiCollection.reloadData()
    }
}
