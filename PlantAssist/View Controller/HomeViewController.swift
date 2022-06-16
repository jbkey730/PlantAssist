//
//  File.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 5/23/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var SignupBtn: UIButton!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()

    }
    
    func setUpElements() {
        Utilities.styleHollowButton(LoginBtn)
        Utilities.styleFilledButton(SignupBtn)

    }
}


