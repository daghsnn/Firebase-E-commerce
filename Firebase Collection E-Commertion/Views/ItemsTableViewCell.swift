//
//  ItemsTableViewCell.swift
//  Mobiroller Firebase Collection E-Commertion
//
//  Created by Hasan Dag on 9.06.2021.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var cellDescrip: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()

        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cellImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)



    }

}
