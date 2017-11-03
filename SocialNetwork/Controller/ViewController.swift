//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 29.10.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func FacebookBtnPressed(_ sender: Any) {
    
    let facebookLogin  = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("DAUD: Unable to authenticate with Facebook \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("DAUD: User cancelled authentication with Facebook")
            } else {
                print("DAUD: User successfully authenticated with Facebook")
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                firebaseAuth(_credential: credential)
            }
        }
        
       func firebaseAuth(_credential: AuthCredential) {
        Auth.auth().signIn(with: _credential) { (user, error) in
            if error != nil {
                print("DAUD: Unable to authenticate with Firebase -\(String(describing: error))")
            } else {
                print("DAUD: Successfully authenticated wiht Firebase -(error)")
            }
        }
        }
        
    }
    
}

