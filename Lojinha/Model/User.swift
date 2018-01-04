//
//  User.swift
//  Momentos
//
//  Created by Bruno Corrêa on 25/04/17.
//  Copyright © 2017 Br4Dev. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    let uid: String
    var email:String
    var userName:String
    var fullName:String
    var profileImage:UIImage?
    
    init(uid:String,email:String,userName:String,fullName:String,profileImage:UIImage?) {
        
        self.uid = uid
        self.email = email
        self.userName = userName
        self.fullName = fullName
        self.profileImage = profileImage
    
    }
    
    init(dictionary:[String:Any]) {
        
        uid = dictionary["uid"] as! String
        email = dictionary["email"] as! String
        userName = dictionary["userName"] as! String
        fullName = dictionary["fullName"] as! String

    }

    func save(completion:@escaping (Error?) -> Void){
        
        let ref = DatabaseRef.user(uid:uid).ref()
        ref.setValue(toDictionary())
        
        if let profileImage = self.profileImage{
            
            let firImage = FIRImage(image: profileImage)
            firImage.saveProfileImage(userUID: self.uid, completion: { (error) in
                completion(error)
            })
        }
    }
    
    func toDictionary() -> [String:Any]{
        
        return [
            "uid": uid,
            "email": email,
            "userName": userName,
            "fullName": fullName,
        ]
    }
}

extension User {

    func downloadProfilePicture(completion: @escaping (UIImage?,NSError?) -> Void){
        FIRImage.downloadProfileImage(uid: uid) { (image, error) in
            self.profileImage = image
            completion(image,error as NSError?)
        }
    }
}

extension User:Equatable{}

func ==(lhs:User, rhs:User) -> Bool{
    return lhs.uid == rhs.uid
}
