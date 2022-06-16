//
//  LoginViewController.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 5/16/22.
//

import UIKit
import FirebaseAuth
//import Firebase
import FirebaseCore

class LoginViewController: UIViewController {

    @IBOutlet weak var Usernametxt: UITextField!
    
    @IBOutlet weak var Passwordtxt: UITextField!
    
    @IBOutlet weak var Loginbtn: UIButton!
    
    @IBOutlet weak var Errorlb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        Errorlb.alpha = 0
        Utilities.styleTextField(Usernametxt)
        Utilities.styleTextField(Passwordtxt)
        Utilities.styleFilledButton(Loginbtn)
    }

    @IBAction func LoginTapped(_ sender: Any) {
        // validate text fields
        
        //creat cleaned version of text field
        let email = Usernametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let passWord = Passwordtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //signing in user
        Auth.auth().signIn(withEmail: email, password: passWord) {
            (result, error) in
            
            if error != nil {
                self.Errorlb.text = error!.localizedDescription
                self.Errorlb.alpha = 1
            }
            else{
                let ViewController =  self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ViewController) as? ViewController
                    
                self.view.window?.rootViewController = ViewController
                    
                self.view.window?.makeKeyAndVisible()
                }
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


