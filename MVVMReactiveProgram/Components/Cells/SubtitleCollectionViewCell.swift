//
//  SubtitleCollectionViewCell.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import UIKit

class SubtitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellSubtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.red.cgColor
    }
    
    func configureCell(title: String, subTitle: String) {
        cellTitle.text = title
        cellSubtitle.text = subTitle
    }
    
    static func cellHeight() -> CGFloat {
        return 100
    }

}
