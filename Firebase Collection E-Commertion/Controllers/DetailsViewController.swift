//
//  DetailsViewController.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 9.06.2021.
//

import UIKit
import Kingfisher


class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var descrpt: UITextView!
    
    @IBOutlet weak var avaibletxt: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    
    var image = UIImage()
    var name:String?
    var descript:String?
    var avaible=Bool()
    var fiyat:String?
    var date:String?
    var imageURL:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.image = image
        imageView.kf.setImage(with: URL(string: imageURL ?? ""))
        nameLbl.text = name
        descrpt.text = descript
        price.text = fiyat
        if avaible == true {
            avaibletxt.text = "This product is avaible in store.."
        }else{
            avaibletxt.text = "This product is not avaible... "
        }
        
    }
    


}
