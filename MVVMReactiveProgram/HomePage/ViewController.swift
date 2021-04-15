//
//  ViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var singleCellButton: UIButton!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        bindViewModel()
        
    }
    
    func bindViewModel() {
        singleCellButton.rx.tap.bind { [unowned self] in
            self.openSingleCellCollectionView()
        }.disposed(by: disposeBag)
    }
    
    func openSingleCellCollectionView() {
        let storyboard = UIStoryboard(name: "CollectionViewTutorial", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewTutorialViewController") as? CollectionViewTutorialViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

class ViewControllerViewModel {
    let disposeBag = DisposeBag()
}
