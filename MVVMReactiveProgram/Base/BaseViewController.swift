//
//  BaseViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    var viewModel: BaseViewModel!
    var disposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
    
    func bindViewModel() {}
    
    func binding() {
        disposeBag = DisposeBag()
        viewModel.disposeBag = DisposeBag()
        
        bindViewModel()
        viewModel.react()
    }
    
}
