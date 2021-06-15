//
//  AddItemViewController.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 9.06.2021.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var itemTxt: UITextField!
    
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var descrTxtView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var category:Categories!
    //var itemImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(category.id)
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        
        if checkFields() == true {
            let alert = UIAlertController(title: "", message: "Item is added", preferredStyle: UIAlertController.Style.alert)
            
            let actionCancel = UIAlertAction(title: "", style: UIAlertAction.Style.cancel, handler: nil)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
              // your code with delay
              alert.dismiss(animated: true, completion: nil)
            }
            
            
            saveFirebaseItem()
            
        }else {
            print("Input the all areas correctly")
        }
        
        
    }
    private func checkFields() -> Bool{
        return (itemTxt.text != "" && priceTxt.text != "" && imageView.image != nil && descrTxtView.text != "")
    }
    
    func saveFirebaseItem(){
        let itemAdd = Items()
        itemAdd.id = UUID().uuidString
        itemAdd.name = itemTxt.text
        itemAdd.categoryId = category.id
        itemAdd.description = descrTxtView.text
        itemAdd.price = Double(priceTxt.text!)
        itemAdd.avaible = true
        itemAdd.image = imageView.image!
        saveItems(itemAdd)
      
            
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func chooseImage() {
           
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        

        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil) }
    

}
