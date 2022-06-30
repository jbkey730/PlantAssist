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
//import LocalAuthentication
import KeychainSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var Usernametxt: UITextField!
    
    @IBOutlet weak var Passwordtxt: UITextField!
    
    @IBOutlet weak var Loginbtn: UIButton!
    
    @IBOutlet weak var Errorlb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //signing in user
//       if let receivedData = KeyChain.load(key: "PlantAssistEmail") {
//           let result = receivedData.to(type: String.self)
//           print("result: ", result)
           //Usernametxt.text = result

//       }
        let keychain = KeychainSwift()

        let keyPassWord = keychain.get("PlantAssistPassword")
        let keyEmail = keychain.get("PlantAssistEmail")

        Passwordtxt.text = keyPassWord
        Usernametxt.text = keyEmail
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        Errorlb.alpha = 0
        Utilities.styleTextField(Usernametxt)
        Utilities.styleTextField(Passwordtxt)
        Utilities.styleFilledButton(Loginbtn)
    }

    @IBAction func frgtPassTapped(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: Usernametxt.text!) { error in
                   DispatchQueue.main.async {
                       if self.Usernametxt.text?.isEmpty==true || error != nil {
                           let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                           resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                           self.present(resetFailedAlert, animated: true, completion: nil)
                       }
                       if error == nil && self.Usernametxt.text?.isEmpty==false{
                           let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
                           resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                           self.present(resetEmailAlertSent, animated: true, completion: nil)
                       }
                   }
               }
    }
    @IBAction func LoginTapped(_ sender: Any) {
        // validate text fields
        //creat cleaned version of text field
        let email = Usernametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let passWord = Passwordtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
//        let stringPassword: String = passWord
//        let passwordData = Data(from: stringPassword)
//        let statusPassword = KeyChain.save(key: "PlantAssistPassword", data: passwordData)
//        print("status: ", statusPassword)
//
//        let stringEmail: String = email
//        let emailData = Data(from: stringEmail)
//        let statusEmail = KeyChain.save(key: "PlantAssistEmail", data: emailData)
//        print("status: ", statusEmail)
    
        let keychain = KeychainSwift()
        keychain.set(passWord, forKey: "PlantAssistPassword")
        keychain.set(email, forKey: "PlantAssistEmail")

        //biometric authintication
        let biometricIDAuth = BiometricIDAuth()

        biometricIDAuth.canEvaluate { (canEvaluate, _, canEvaluateError) in
            guard canEvaluate else {
                // Face ID/Touch ID may not be available or configured
                return
            }
            
            biometricIDAuth.evaluate { [weak self] (success, error) in
                guard success else {
                    // Face ID/Touch ID may not be configured
                    return
                }
                
        Auth.auth().signIn(withEmail: email, password: passWord) {
            (result, error) in
            
            if error != nil {
                self?.Errorlb.text = error!.localizedDescription
                self?.Errorlb.alpha = 1
            }
            else{
                let ViewController =  self?.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ViewController) as? ViewController
                    
                self?.view.window?.rootViewController = ViewController
                    
                self?.view.window?.makeKeyAndVisible()
                }
            }
        //save info in keychain
                //guard let userName = self?.Usernametxt.text,
                //      let password = self?.Passwordtxt.text else { return }
                    
                //let keychain = KeychainSwift()
                //keychain.accessGroup = "com.PlantAssist"
                //keychain.set(userName, forKey: "userName")
                //keychain.set(password, forKey: "password")
                    
                // The next flow is navigation. Basically, it pushes to ReadBlogsViewController

                
                // You are successfully verified
            }
        }

        }//ibaction end
    }//class end
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


