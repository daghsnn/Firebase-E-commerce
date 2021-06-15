//
//  Catagories.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 6.06.2021.
//

import Foundation
import UIKit
import Firebase

class Categories{
    var id:String
    var name:String
    var image:UIImage?
    var imageName:String?
    var imageURL:String?
    init(_name:String, _imageName:String, _image:UIImage)
    {
        id = ""
        name = _name
        imageName = _imageName
        image = _image
        
    }
    init(_dictionary : NSDictionary)
    {
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[kNAME] as! String
        image  = UIImage(named: _dictionary[kIMAGENAME] as? String ?? "")
        imageURL = _dictionary[kIMAGEURL] as? String
        
    }
}

func saveCategories(_ category: Categories){
    let id = UUID().uuidString
    category.id = id
    
    let storage = Storage.storage()
    let storageReference = storage.reference()
    
    let mediaFolder = storageReference.child("CategorieFiles")
    
    if let data = category.image!.jpegData(compressionQuality: 1.0) {
        
        let imageReference = mediaFolder.child("\(id).jpg")
        
        imageReference.putData(data, metadata: nil) {(metadata, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                imageReference.downloadURL { (url, err) in
                    if err != nil {
                        print(err?.localizedDescription)
                    }else{
                        category.imageURL = url!.absoluteString
                        FirebaseRef(.Category).document(id).setData(categoryDictionary(category) as! [String : Any])
                    }
                }
            
            }
        }
    }
  
}

func categoryDictionary(_ category: Categories) -> NSDictionary {
    return NSDictionary(objects: [category.id, category.name,  category.imageName, category.imageURL], forKeys: [kOBJECTID as NSCopying, kNAME  as NSCopying, kIMAGENAME  as NSCopying, kIMAGEURL as NSCopying])
}

func downloadCategories(completion:@escaping (_ categoryArray: [Categories])-> Void){
    
    var categoryArray : [Categories] = []
    FirebaseRef(.Category).getDocuments {
        (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(categoryArray)
            return print(error?.localizedDescription)}
        if !snapshot.isEmpty {
            for categoryDic in snapshot.documents {
            
                categoryArray.append(Categories(_dictionary: categoryDic.data() as NSDictionary))
                
            }
        }
        completion(categoryArray)
        
    }
    
}
