//
//  TypeOneCollectionViewCell.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//

import UIKit

class TypeOneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.red.cgColor
    }
    
    func configureCell(cellTitle title: String) {
        cellTitle.text = title
    }

}
