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
    @IBOutlet weak var mutableCellButton: UIButton!
    @IBOutlet weak var mutableSectionCellButton: UIButton!
    @IBOutlet weak var pagingViewButton: UIButton!
    
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
        
        mutableCellButton.rx.tap.bind { [unowned self] in
            self.openMutableCellCollectionView()
        }.disposed(by: disposeBag)
        
        mutableSectionCellButton.rx.tap.bind { [unowned self] in
            self.openMutableSectionCellCollectionView()
        }.disposed(by: disposeBag)
        
        pagingViewButton.rx.tap.bind { [unowned self] in
            self.openPagingView()
        }.disposed(by: disposeBag)
    }
    
    func openSingleCellCollectionView() {
        let storyboard = UIStoryboard(name: "CollectionViewTutorial", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewTutorialViewController") as? CollectionViewTutorialViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMutableCellCollectionView() {
        let storyboard = UIStoryboard(name: "MutableCellCollectionView", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MutableCellCollectionViewViewController") as? MutableCellCollectionViewViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMutableSectionCellCollectionView() {
        let storyboard = UIStoryboard(name: "MutableSectionSingleCell", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MutableSectionSingleCellViewController") as? MutableSectionSingleCellViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openPagingView() {
        let storyboard = UIStoryboard(name: "Paging", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ParentPagingViewController") as? ParentPagingViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

class ViewControllerViewModel {
    let disposeBag = DisposeBag()
}
