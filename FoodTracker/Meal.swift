//
//  Meal.swift
//  FoodTracker
//
//  Created by Erica Clark on 6/2/16.
//  Copyright © 2016 Erica Clark. All rights reserved.
//

import UIKit

class Meal : NSObject, NSCoding {
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: File Path
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey{
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    init?(name: String, photo:UIImage?, rating: Int){
        if(name.isEmpty || rating < 0)
        {
            return nil
        }
        
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        self.init(name: name, photo: photo, rating: rating)
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    

}
