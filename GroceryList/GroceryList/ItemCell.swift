//
//  ItemCell.swift
//  GroceryList
//
//  Created by Ethan Hess on 1/13/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var theTitleLabel: UILabel!
    @IBOutlet var theDetailLabel: UILabel!
    @IBOutlet var theImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
