//
//  DetailViewController.swift
//  GroceryList
//
//  Created by Ethan Hess on 1/8/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    
    var groceryItem : GroceryItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpViews()
    }
    
    func updateWithItem(groceryItem: GroceryItem) {
        
        self.groceryItem = groceryItem;
    }
    
    func setUpViews() {
        
        self.title = self.groceryItem.title!
        
        self.titleLabel.text = self.groceryItem.title!
        self.descriptionLabel.text = self.groceryItem.itemDescription!
        self.quantityLabel.text = String(self.groceryItem.quantity)
        
        self.titleLabel.layer.cornerRadius = 15
        self.descriptionLabel.layer.cornerRadius = 15
        self.quantityLabel.layer.cornerRadius = 15
        
        self.titleLabel.layer.masksToBounds = true
        self.descriptionLabel.layer.masksToBounds = true
        self.quantityLabel.layer.masksToBounds = true
        
        self.titleLabel.layer.borderColor = UIColor.white.cgColor
        self.descriptionLabel.layer.borderColor = UIColor.white.cgColor
        self.quantityLabel.layer.borderColor = UIColor.white.cgColor
        
        self.titleLabel.layer.borderWidth = 3
        self.descriptionLabel.layer.borderWidth = 3
        self.quantityLabel.layer.borderWidth = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
