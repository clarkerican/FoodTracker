//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Erica Clark on 5/22/16.
//  Copyright © 2016 Erica Clark. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: FoodTracker Tests
    func testMealInitialization(){
        let potentialItem = Meal(name: "Caprese", photo: nil, rating: 5)
        
        XCTAssertNotNil(potentialItem)
        
        let noName = Meal(name : "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invlaid")
        
        let badRating = Meal(name : "Bad Rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings should be positive")
        
    }
    
    
}
