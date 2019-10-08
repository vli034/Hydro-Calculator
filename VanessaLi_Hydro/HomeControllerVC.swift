//
//  ViewController.swift
//  VanessaLi_Hydro
//
/// VANESSA LI - 991508257 - ASSIGNMENT 1 / 2 
//  Created by Vanessa Li on 2019-09-28.
//  Copyright © 2019 Vanessa Li. All rights reserved.
//

import UIKit

class HomeControllerVC: UIViewController, UITextFieldDelegate {
    
    // Global Variables
    var onPeak: String = ""
    var midPeak: String = ""
    var offPeak : String = ""
    var email : String = ""
    var phone : String = ""
    var value1 : Double = 0.0
    var value2 : Double = 0.0
    var value3 : Double = 0.0
    
    //Outlets
    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var phoneTextInput: UITextField!
    
    @IBOutlet weak var onPeakInput: UITextField!
    @IBOutlet weak var midPeakInput: UITextField!
    @IBOutlet weak var offPeakInput: UITextField!
    
    
    @IBOutlet weak var labelEmail: UITextField!
    @IBOutlet weak var labelPhoneNum: UITextField!
    
    
 
    // this function is the function that is loaded when our application first starts
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate allows us this class to implement built in methods
        phoneTextInput.delegate = self
        emailTextInput.delegate = self
        onPeakInput.delegate = self
        midPeakInput.delegate = self
        offPeakInput.delegate = self
        
    }
    
   //allows keyboard removal when user clicks on enter - using default keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextInput.resignFirstResponder()
        return true  //method returns true -otherwise false
    }

    //Method implemented to toggle NUMBER PAD Keyboard - when user touches outside of txtfield keyboard will go away -- touches textfield to re-appear
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneTextInput.endEditing(true)
        onPeakInput.endEditing(true)
        midPeakInput.endEditing(true)
        offPeakInput.endEditing(true)
    }
    
    //Storing the email address and the phone number and displaying it on terminal
    // i used a function bc the assignment does not ask us to pass this data so i had isolated this specific instance 
    func emailAndPhone(){
        // print to terminal -- might need to scroll pass the constraint warnings to see the values
        print(labelEmail.text!)
        print(labelPhoneNum.text!)
    
    }

    
    //Action functions - Calculate Button
    @IBAction func calculateButton(_ sender: UIButton) {
        validatingInput()
        emailAndPhone()
        // manually resetting textfields to empty string
        onPeakInput.text = ""
        midPeakInput.text = ""
        offPeakInput.text = ""
        phoneTextInput.text = ""
        emailTextInput.text = ""
        labelEmail.text = ""
        labelPhoneNum.text = ""
        
    }
    
    
    // function that checks if user has entered values
     func validatingInput(){
        // giving our global variables some default values
        onPeak = onPeakInput.text ?? ""
        midPeak = midPeakInput.text ?? ""
        offPeak = offPeakInput.text ?? ""
        
        //checking if text fields are empty
        if onPeakInput.text?.count != 0 && midPeakInput.text?.count != 0 && offPeakInput.text?.count != 0{
            calculateHydroAmount()
        } else { //If user has left peak values empty then call the alertbox function
           showAlertBox(attempt: false)
        }
    }
    
    //Calculating stuff
    func calculateHydroAmount(){
        //formatting doubles to 2 decimal places
        value1 =  ((Double(onPeak)! * 0.132) * 100).rounded()/100
        value2 =  ((Double(midPeak)! * 0.094) * 100).rounded()/100
        value3 =  ((Double(offPeak)! * 0.065) * 100).rounded()/100
        

        //Check to see if values are greater than 0 before moving on to next screen
        if value1 > 0 && value2 > 0 && value3 > 0 {
            navigateToNextStoryBoard()
        }
        
        
    }
    
    //Navigate to Next Story board that Displays the data
    func navigateToNextStoryBoard(){
     
        let nextStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let totalVC = nextStoryBoard.instantiateViewController(withIdentifier: "TotalAmountID") as! TotalAmountVC
        // passing our  global values from user input to next screen ( TotalVC) via assignment
        totalVC.value1 = self.value1
        totalVC.value2 = self.value2
        totalVC.value3 = self.value3
        totalVC.onPeak = self.onPeak
        totalVC.offPeak = self.offPeak
        totalVC.midPeak = self.midPeak
     
        //push to next screen called totalVC
        navigationController?.pushViewController(totalVC, animated: true)
    }
    
    
    //Function to create alert boxes when user input is empty
    func showAlertBox(attempt: Bool){
        //assigned empty value to string
        var msg: String = ""
        if attempt{ // if attempt returns true - it will say ..
            msg = "this works"
        } else {// if attempt returns false -- it will say
            msg = "Try Again"
        }
        //the message that pops up when error occurs
        let alertController = UIAlertController(title: "You can not leave peak values empty", message: msg, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil)) //add action to cancel alert box
        self.present(alertController, animated: true, completion: nil) // this makes the alert box show up when funcfion is called
    }

    
}// end bracket

