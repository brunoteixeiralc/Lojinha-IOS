//
//  FirebaseReference.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 03/01/2018.
//

import Foundation
import Firebase

enum DatabaseRef {
    
    case root
    case user(uid:String)
    
    func ref() -> DatabaseReference {
        return rootRef.child(path)
    }
    
    private var rootRef: DatabaseReference {
        return Database.database().reference()
    }
    
    private var path:String {
        
        switch self {
        case .root:
            return ""
        case .user(let uid):
            return "users/\(uid)"
            
        }
    }
}

enum StorageRef {
    
    case root
    case profileImages
    
    func ref() -> StorageReference {
        return baseRef.child(path)
    }
    
    private var baseRef:StorageReference {
        return Storage.storage().reference()
    }
    
    private var path:String {
        
        switch self {
        case .root:
            return ""
        case .profileImages:
            return "profileImages"
            
        }
    }
}
