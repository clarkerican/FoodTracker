//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Erica Clark on 5/26/16.
//  Copyright © 2016 Erica Clark. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()  //property  observer, when didSet is triggered, this event/function occurs
        }
    }
    var buttons = [UIButton]()
    let spacing = 5
    let starCount = 5


    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        let filledStarImage = UIImage(named: "Filled Star");
        let emptyStarImage = UIImage(named: "Empty Star");
        
        
        for _ in 0 ..< starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage,forState: .Selected)
            button.setImage(filledStarImage,forState: [.Highlighted,.Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)),  forControlEvents: .TouchDown)
            buttons += [button]
            self.addSubview(button)
        }

    }
    
    override func layoutSubviews() {
        let starSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y:0,width: starSize,height: starSize)
        
        
        for (index,button) in buttons.enumerate(){
            buttonFrame.origin.x = CGFloat(index * (starSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectedStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
            let starSize = Int(frame.size.height)
        let width = (starSize * starCount) + (spacing * (starCount - 1))
        return CGSize(width: width, height: starSize)
    }
    
    //MARK: Button Action

    func ratingButtonTapped(button : UIButton){
        rating = buttons.indexOf(button)! + 1
        updateButtonSelectedStates()
    }
    
    func updateButtonSelectedStates(){
        
        for(index,button) in buttons.enumerate(){
            button.selected = index < rating
        }
    }
    
    
}
