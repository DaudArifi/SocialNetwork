//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Daud Arifi on 21.11.17.
//  Copyright © 2017 Daud Arifi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImage: CircleView!
    @IBOutlet weak var captionField: UITextField!
    
    var posts = [Post]()
    
    var imagePicker: UIImagePickerController!
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKEY: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            if let img = FeedVC.imageCache.object(forKey: post.imageURL as NSString) {
                cell.configureCell(post: post, image: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
    } else {
            return PostCell()
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if let imageView = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = imageView
            imageSelected = true
        } else {
            print("DAUD: not found valid image")
        }
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postBtnTapped(_ sender: AnyObject) {
        guard let caption = captionField.text, caption != "" else {
            print("DAUD: Caption must be entered!")
        return
        }
        guard let img = addImage.image, imageSelected == true else {
            print("DAUD: A image must be selected!")
        return
        }
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("DAUD: Unable to upload image to Firebase storage!")
                } else {
                    print("DAUD: successfully uploaded image to Firebase storage!")
                let downloadURL = metadata?.downloadURL()?.absoluteString
                }
            }
        }
    }
    
    @IBAction func signOutTapped(sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("DAUD: User ID removed successfully")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}

