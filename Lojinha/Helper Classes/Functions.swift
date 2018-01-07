//
//  Functions.swift
//  meuslugares
//
//  Created by Bruno Lemgruber on 26/12/2017.
//  Copyright © 2017 Bruno Lemgruber. All rights reserved.
//

import Foundation

let FirebaseFailedNotification = Notification.Name("FirebaseFailedNotification")

func fatalFirebaseError(_ error: Error){
    print("***Fatal error: \(error)")
    NotificationCenter.default.post(name: FirebaseFailedNotification, object: nil)
}
