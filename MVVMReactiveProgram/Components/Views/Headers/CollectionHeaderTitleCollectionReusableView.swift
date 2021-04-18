//
//  CollectionHeaderTitleCollectionReusableView.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/18/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import UIKit

class CollectionHeaderTitleCollectionReusableView: UICollectionReusableView {
    static let identifier = "CollectionHeaderTitleCollectionReusableView"
    
    @IBOutlet weak var titleHeaderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureHeader(title: String) {
        titleHeaderLabel.text = title
    }
    
}
