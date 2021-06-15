//
//  Items.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 8.06.2021.
//

import Foundation
import UIKit
import Firebase

class Items {
    var id : String!
    var categoryId : String!
    var name : String!
    var description : String!
    var price : Double!
    var avaible : Bool!
    var imageLinks : String!
    var image : UIImage!
    init(){}
    
    init(_dictionary : NSDictionary)
    {
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[iNAME] as! String
        categoryId = _dictionary[iCATEGORYID] as! String
        description = _dictionary[iDESCRİPTİON] as! String
        price = _dictionary[iPRICE] as! Double
        avaible = _dictionary[iAVAIBLE] as! Bool
        imageLinks = _dictionary[iIMAGELINKS] as! String
        image  = UIImage(named: _dictionary[iIMAGELINKS] as? String ?? "")

    }
    
}
func itemDictionary(_ item: Items) -> NSDictionary {
    return NSDictionary(objects: [item.id, item.name,  item.categoryId, item.description, item.price, item.avaible, item.imageLinks], forKeys: [kOBJECTID as NSCopying, iNAME  as NSCopying, iCATEGORYID  as NSCopying, iDESCRİPTİON as NSCopying, iPRICE as NSCopying,iAVAIBLE as NSCopying, iIMAGELINKS as NSCopying])
}

func saveItems(_ item: Items){
    let id = UUID().uuidString
    item.id = id
    let storage = Storage.storage()
    let storageReference = storage.reference()
    
    let mediaFolder = storageReference.child("CategorieFiles")
    
    if let data = item.image!.jpegData(compressionQuality: 1.0) {
        
        let imageReference = mediaFolder.child("\(id).jpg")
        
        imageReference.putData(data, metadata: nil) {(metadata, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                imageReference.downloadURL { (url, err) in
                    if err != nil {
                        print(err?.localizedDescription)
                    }else{
                        item.imageLinks = url!.absoluteString
                        FirebaseRef(.Items).document(item.id).setData(itemDictionary(item) as! [String : Any])
                    }
                }
            
            }
        }
    }
    
    
   
    
    
}
func downloadItems(completion:@escaping (_ categoryArray: [Items])-> Void){
    
    var itemarray : [Items] = []
    FirebaseRef(.Items).getDocuments {
        (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(itemarray)
            return print(error?.localizedDescription)}
        if !snapshot.isEmpty {
            for itemDic in snapshot.documents {
            
                itemarray.append(Items(_dictionary: itemDic.data() as NSDictionary))
                
            }
        }
        completion(itemarray)
        
    }
    
}
