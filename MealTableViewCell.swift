//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Erica Clark on 6/5/16.
//  Copyright © 2016 Erica Clark. All rights reserved.
//

import UIKit


class MealTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var mealPhoto: UIImageView!
    @IBOutlet weak var mealRating: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
