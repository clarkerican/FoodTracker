//
//  ViewController.swift
//  FoodTracker
//
//  Created by Erica Clark on 5/22/16.
//  Copyright © 2016 Erica Clark. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    // MARK: Properties
    
    @IBOutlet weak var mealTextField: UITextField!  //IB is interface builder which allows 
                                                    // us to connect to the text field
                                                    // weak - possible to have no value
                                                    // ! - implicitly unwrapped optional
    
    
    @IBOutlet weak var mealPhoto: UIImageView!
    @IBOutlet weak var ratingView: RatingControl!
    @IBOutlet weak var save: UIBarButtonItem!
    var meal: Meal?
    
    //MARK : Delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //hide keyboard
        mealTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        navigationItem.title = mealTextField.text
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        save.enabled = false
    }
    
    func checkValidName(){
        let name = mealTextField.text ?? ""
        save.enabled = name != ""
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
            // Set photoImageView to display the selected image.
         mealPhoto.image = selectedImage
        
            // Dismiss the picker.
         dismissViewControllerAnimated(true, completion: nil)

    }
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if save === sender{
            let name = mealTextField.text ?? ""
            let photo = mealPhoto.image
            let rate = ratingView.rating
            meal = Meal(name: name, photo: photo, rating: rate)
            
        }
    }
    

    
    // MARK: Actions
    
    @IBAction func photoTapControl(sender: UITapGestureRecognizer) {
        mealTextField.resignFirstResponder();
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary  //enum for UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let meal = meal {
            navigationItem.title = meal.name
            mealTextField.text = meal.name
            mealPhoto.image = meal.photo
            ratingView.rating = meal.rating
        }
        
        checkValidName()
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController // bool
        
        if  isPresentingInAddMealMode{
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}