//
//  MutableSectionMutableCellViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/18/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import UIKit

class MutableSectionMutableCellViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        viewModel = MutableSectionMutableCellViewModel()
        super.viewDidLoad()
        
    }
    
    override func bindViewModel() {
        
    }
}
