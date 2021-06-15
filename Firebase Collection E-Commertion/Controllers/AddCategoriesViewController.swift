//
//  AddCategoriesViewController.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 7.06.2021.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class AddCategoriesViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var categorieName: UITextField!
    
    @IBOutlet weak var categorieImg: UIImageView!
    
    @IBOutlet weak var saveBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            categorieImg.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
            categorieImg.addGestureRecognizer(gestureRecognizer)
       
    }
    @objc func chooseImage() {
           
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        

        categorieImg.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil) }
    
        
     @IBAction func saveBtnClicked(_ sender: Any) {
        
        createCategory()
        let alert = UIAlertController(title: "", message: "Category is added", preferredStyle: UIAlertController.Style.alert)
        
        let actionCancel = UIAlertAction(title: "", style: UIAlertAction.Style.cancel, handler: nil)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
          alert.dismiss(animated: true, completion: nil)
        }
        
    }
    func createCategory(){
        let categoryAdd = Categories.init(_name: categorieName.text!, _imageName: categorieName.text!, _image: categorieImg.image!)
            saveCategories(categoryAdd)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
