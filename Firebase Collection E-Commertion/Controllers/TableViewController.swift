//
//  DetailViewController.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 2.06.2021.
//

import UIKit
import Kingfisher
import Firebase

class TableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
        
  
    let db = Firestore.firestore()
    var category: Categories?
    var items : [Items] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = category?.name

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        loadItems()
        }
    
    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "addItemSegue", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as? DetailsViewController
        vc?.descript = items[indexPath.row].description
        vc?.name = items[indexPath.row].name
        vc?.avaible = items[indexPath.row].avaible
        vc?.fiyat = String(items[indexPath.row].price)
        vc?.imageURL = items[indexPath.row].imageLinks
        self.navigationController?.pushViewController(vc!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItemsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ItemsTableViewCell
        
        let url = URL(string: items[indexPath.row].imageLinks ?? "\(items[indexPath.row].categoryId)")
        if items[indexPath.row].avaible == true {
        cell.imageView?.kf.setImage(with: url)
        cell.itemName.text = items[indexPath.row].name
        cell.unit.text = String(items[indexPath.row].price)
        cell.cellDescrip.text = items[indexPath.row].description
        
        }
        else {
            print("This item not avaible anymore..")
        }
        
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let storage = Storage.storage()
            let storageRef = storage.reference(withPath: "/CategorieFiles")

            // success finally
            let deletedRef = storageRef.child(items[indexPath.row].id+".jpg")

            deletedRef.delete { error in
              if let error = error {
              } else {
              }
            }
            FirebaseRef(.Items).document(items[indexPath.row].id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Item successfully removed!")
                }
            }
            items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            let vc = segue.destination as! AddItemViewController
            vc.category = category
        }
    }
    
    func downloadItemswithId(_ categoryId:String, completion: @escaping (_ itemarray:[Items])->Void){
        
        
        var itemArray:[Items] = []
        FirebaseRef(.Items).whereField(iCATEGORYID, isEqualTo: categoryId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else{return print(error?.localizedDescription)}
            if !snapshot.isEmpty {
                for itemDic in snapshot.documents {
                
                    itemArray.append(Items(_dictionary: itemDic.data() as NSDictionary))
                    
                }
            }
            completion(itemArray)
        }
    }
    func loadItems(){
        downloadItemswithId(category!.id) { (items) in
            self.items = items
            self.tableView.reloadData()
        }
    }
}
