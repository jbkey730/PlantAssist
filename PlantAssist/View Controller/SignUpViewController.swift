//
//  SignUpViewController.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 5/16/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
//import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var FirstNametxt: UITextField!
    
    @IBOutlet weak var LastNametxt: UITextField!
        
    @IBOutlet weak var Phonenumtxt: UITextField!
    
    @IBOutlet weak var Signupbtn: UIButton!
    
    @IBOutlet weak var Errorlb: UILabel!
    
    @IBOutlet weak var Emailtxt: UITextField!
    
    @IBOutlet weak var Passwordtxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        Errorlb.alpha=0
        Utilities.styleTextField(FirstNametxt)
        Utilities.styleTextField(LastNametxt)
        Utilities.styleTextField(Emailtxt)
        Utilities.styleTextField(Phonenumtxt)
        Utilities.styleTextField(Passwordtxt)
        Utilities.styleFilledButton(Signupbtn)

    }
    //check field and validate that the data is correct
    func validateFields() -> String?{
        //check all fields are filled in
        if FirstNametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || LastNametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || Emailtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || Phonenumtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || Passwordtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
            
        }
        //check if password is secure
        let cleanedPassword = Passwordtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // password isn't secure
            return "Plase make sure you password contains at least 8 characters, a special character, and a number."
            
        }
        return nil
    }
    
    @IBAction func SignupTapped(_ sender: Any) {
        /// validate fields
        ///
        let error = validateFields()
        
        if error != nil {
            //These is something wrong show error message
            showError(error!)
        }
        else{
            //create cleaned version of the data
            let firstName = FirstNametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = LastNametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passWord = Passwordtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = Emailtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = Phonenumtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            /// create user
            Auth.auth().createUser(withEmail: email, password: passWord) {
                (result, err) in
                //check for errors
                
               // let error = error!
                
                if err != nil {
                    //there was an error
                    showError("Email already exists. Please try again.")
                }
                else{
                    
                    //users was created successfully store first and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName":firstName,"lastName":lastName,"email":email,"passWord":passWord, "phoneNumber":phoneNumber,"uid": result?.user.uid ?? "default"]) {(error) in
                    if error != nil {
                        //show error meassage
                        showError("User failed. Try again.")
                    }
                }
                
            
            /// transistion to home screen
            transitionHome()
            }
        }
        
    }//signuptapped function end

        func showError(_ message:String ) {
            Errorlb.text = message
            Errorlb.alpha = 1
        }
            
        func transitionHome() {
            let ViewController =  storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ViewController) as? ViewController
                
                view.window?.rootViewController = ViewController
                
                view.window?.makeKeyAndVisible()
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
