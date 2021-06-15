//
//  CollectionViewController.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 6.06.2021.
//

import UIKit
import Kingfisher

class CollectionViewController: UICollectionViewController {

    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var categorymodels:[Categories] = []
   // private let sectionInserts = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    //private let itemsRow:CGFloat = 3
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let satirElemanSayisi : CGFloat = 3
            let bosluk : CGFloat = 4
         
            
            let toplamBosluk = bosluk * (satirElemanSayisi - 1)
            let itemBosluk = toplamBosluk / satirElemanSayisi
            let genislik = collectionView.frame.width / satirElemanSayisi - itemBosluk
            let yukseklik = genislik
            layout.itemSize = CGSize(width: genislik, height: yukseklik)
          
            layout.minimumInteritemSpacing = bosluk
          
            layout.minimumLineSpacing = bosluk
            
        }
        
      
        
       
        }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.rightBarButtonItem = editButtonItem
        collectionView.dataSource = self
        collectionView.delegate = self
        downloadCategories { (category) in
            print(self.categorymodels.count)
            self.categorymodels = category
            self.collectionView.reloadData()
        }
        
        
    }

    
    // MARK: UICollectionViewDataSource

    @IBAction func editBtn(_ sender: Any) {
        
        
        
    }
    //
    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            
            addButton.isEnabled = !editing
            if let indexPaths = collectionView?.indexPathsForVisibleItems {
                for indexPath in indexPaths {
                    if let cell = collectionView?.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                        cell.isEditing = editing
                        cell.categoryid = categorymodels[indexPath.row].id
                        collectionView.reloadData()
                    }
                }
            }
    }
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "addCategories", sender: self)
        
    }
    
   
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categorymodels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CategoryCollectionViewCell
        cell.labelCell.text = categorymodels[indexPath.row].name
        let url = URL(string: categorymodels[indexPath.row].imageURL ?? "\(categorymodels[indexPath.row].id)")
        cell.imgViewcell.kf.setImage(with: url)
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItemsVC", sender: categorymodels[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemsVC" {
            let vc = segue.destination as! TableViewController
            vc.category = sender as? Categories
        }
    }

}

/*extension CollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftpadding = sectionInserts.left * (itemsRow + 1)
        let avaiblewidth = view.frame.width - leftpadding
        let witdhperitem = avaiblewidth / itemsRow
        
        return CGSize(width: witdhperitem, height: witdhperitem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}*/
