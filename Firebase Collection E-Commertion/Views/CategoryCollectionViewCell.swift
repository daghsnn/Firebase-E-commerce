//
//  CollectionViewCell.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 2.06.2021.
//

import UIKit
import Firebase

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgViewcell: UIImageView!
    
    @IBOutlet weak var labelCell: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var deleteButtonBack: UIVisualEffectView!
    
    var categoryid:String?
    
    var isEditing:Bool = false {
        didSet{
            deleteButtonBack.isHidden = !isEditing
        }
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
        /*self.selectlabel.layer.cornerRadius = 15
        self.selectlabel.layer.masksToBounds = true
        self.selectlabel.layer.cornerRadius = UIColor.white.cgColor
        self.selectlabel.layer.borderWidth = 1.0
        self.selectlabel.backgroundColor = UIColor.black.withAlphaComponent(1.0)
        */
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: "/CategorieFiles")

        // success finally
        let deletedRef = storageRef.child(categoryid!+".jpg")

        deletedRef.delete { error in
          if let error = error {
          } else {
          }
        }
        FirebaseRef(.Category).document(categoryid!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Item successfully removed!")
            }
        }
        var deleteItem = FirebaseRef(.Items).whereField("categoryID", isEqualTo: categoryid).getDocuments { (result, error) in
            if error == nil{
                    for document in result!.documents{
                        FirebaseRef(.Items).document(document.documentID).delete()
                        
                    }
                }
        
        
        
        
        
    }
}
}
