//
//  SignInVC.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 29.10.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var EmailField: FancyField!
    @IBOutlet weak var PasswordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "segueToFeedVC", sender: nil)
        }
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
                print("DAUD: Successfully authenticated wiht Firebase")
                if let user = user {
                self.completeSignIn(id: user.uid)
                }
        }
        }
    }
          }
    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = EmailField.text, let pwd = PasswordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("DAUD: Email user authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("DAUD: Unable to authenticate with Firebase using email")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        } else {
                            print("DAUD: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
            func completeSignIn(id: String) {
                let KeyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
                print("DAUD: Data saved to keychain - \(KeyChainResult)")
                performSegue(withIdentifier: "segueToFeedVC", sender: nil)
            }
        }

