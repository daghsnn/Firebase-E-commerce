//
//  FirebaseReference.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 6.06.2021.
//

import Foundation
import FirebaseFirestore

enum References: String{
    case Category, Items
    
    
}

func FirebaseRef(_ collectionRef:References)->CollectionReference{
    return Firestore.firestore().collection(collectionRef.rawValue)
    
    
    
}
