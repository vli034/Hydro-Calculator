//
//  TotalAmountVC.swift
//  VanessaLi_Hydro
//
/// VANESSA LI - 991508257 - ASSIGNMENT 1 / 2 
//  Created by Vanessa Li on 2019-09-28.
//  Copyright © 2019 Vanessa Li. All rights reserved.
//

import UIKit

class TotalAmountVC: UIViewController {
    //Global Variables
    var value1 : Double = 0.0
    var value2 : Double = 0.0
    var value3 : Double = 0.0
    var onPeak : String = ""
    var midPeak : String = ""
    var offPeak : String = ""
    var regulatoryCharge : Double = 3.28
    var totalCharge : Double = 0.0
    var HST : Double = 0.13
    var hstAmount : Double = 0.0
    var provincialRebate: Double = 0.08
    var rebateAmount : Double = 0.0
    var totalBillAmount : Double = 0.0
    
    
    
    //IBOUTLETS
    @IBOutlet weak var onPeakDollarValue: UILabel!
    @IBOutlet weak var midPeakDollarValue: UILabel!
    @IBOutlet weak var offPeakDollarValue: UILabel!
    
    @IBOutlet weak var regulatoryChargeLabel: UILabel!
    @IBOutlet weak var totalChargesLabel: UILabel!
    @IBOutlet weak var hstChargeLabel: UILabel!
    @IBOutlet weak var rebateLabel: UILabel!
    @IBOutlet weak var totalFinalAmountLabel: UILabel!
    
    @IBOutlet weak var peakKWHLabel: UILabel!
    @IBOutlet weak var midKWHLabel: UILabel!
    @IBOutlet weak var offKWHLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //on load display the values we are retrieving from HomeControllerVC
        onPeakDollarValue.text = "$" + String(self.value1)
        midPeakDollarValue.text = "$" + String(self.value2)
        offPeakDollarValue.text = "$" + String(self.value3)
        regulatoryChargeLabel.text = "$" + String(self.regulatoryCharge)
        peakKWHLabel.text = "\(onPeak) kWh @ $0.132/kwh"
        midKWHLabel.text = "\(midPeak) kWh @ $0.094/kwh"
        offKWHLabel.text = "\(offPeak) kWh @ $0.065/kwh"

        
        //Values that needed calculations were made into functions and called when screen loads
        totalChargesCalculation()
        HSTCalculation()
        rebateCalculation()
        finalAmount()
        
    }
    
    //Function to calculate total charge = on/mid/off peak + regulatory
    func totalChargesCalculation(){
        totalCharge = value1 + value2 + value3 + regulatoryCharge
        totalChargesLabel.text = "$\(totalCharge)"
    }
    
    //Function for HST - HST * total charges
    func HSTCalculation(){
        hstAmount = HST * totalCharge
        hstChargeLabel.text = "$\((hstAmount * 100).rounded()/100)"
        
    }
    
    //Provincial rebates is 8% of total charges
    func rebateCalculation(){
        rebateAmount = provincialRebate * totalCharge
        rebateLabel.text = "$\((rebateAmount * 100).rounded()/100)"
        
    }
    
    //Final Calculation Client must pay is totalcharges + HST - provincial
    func finalAmount(){
        let finalHydro = totalCharge + hstAmount - rebateAmount
        totalFinalAmountLabel.text = "$\((finalHydro * 100).rounded()/100)"
    }
    
    
   

}// end bracket
