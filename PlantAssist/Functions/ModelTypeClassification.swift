//
//  ModelTypeClassification.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 6/29/22.
//

import Foundation
import UIKit
import Vision

class mlResults {
    
    static func clubResult(_ obsResult: VNClassificationObservation ,_ textView :UILabel! ) {
        //extract confidence rate
        let confidenceRate = (obsResult.confidence) * 100

        //print(topResult)
        var topResultDec: String
        topResultDec = NSString(format: "%.2f",confidenceRate) as String

        let threshed: Double = 50
        let thresh: String = String(format: "%.2f", threshed)
        let laxText: String = "Lax Wheat"
        let clubText: String = "Club Wheat"

        if topResultDec > thresh {
            DispatchQueue.main.async {
                //self.navigationItem.title = "Lax Wheat
                textView.text = laxText + "_" + topResultDec
                //seedImagelb = nil
                //self.navigationItem.title = String(topResultDec)
                //self.navigationController?.navigationBar.barTintColor = UIColor.orange
                //self.navigationController?.navigationBar.isTranslucent = false
                                        }
        }
            else{
                DispatchQueue.main.async {
                    //self.navigationItem.title = String(topResultDec) //"Club
                    //self.navigationItem.title = "Club Wheat"
                    textView.text = clubText + "_" + topResultDec
                    //seedImagelb = nil

                    //self.navigationController?.navigationBar.barTintColor = UIColor.yellow
                    //self.navigationController?.navigationBar.isTranslucent = false
                    }
            }
    }
   
    static func inceptionResult(_ obsResult: VNClassificationObservation ,_ textView :UILabel! ) {
        //extract confidence rate
        let confidenceRate = (obsResult.confidence) * 100

        //print(topResult)
        var topResultDec: String
        topResultDec = NSString(format: "%.2f",confidenceRate) as String

            DispatchQueue.main.async {
                //self.navigationItem.title = "Lax Wheat
                textView.text = obsResult.identifier + "_" + topResultDec
                //seedImagelb = nil
                //self.navigationItem.title = String(topResultDec)
                //self.navigationController?.navigationBar.barTintColor = UIColor.orange
                //self.navigationController?.navigationBar.isTranslucent = false
                }
    }
}
