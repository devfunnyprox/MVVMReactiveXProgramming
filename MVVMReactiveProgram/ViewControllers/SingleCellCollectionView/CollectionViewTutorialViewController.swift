//
//  CollectionViewTutorialViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CollectionViewTutorialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    let viewModel = CollectionViewTutorialViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        bindViewModel()
        fetchData()
    }
    
    func configureCollectionView() {
        collectionView.register(UINib.init(nibName: "SingleTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleTitleCollectionViewCell")
    }
    
    func bindViewModel() {
        
        viewModel.title.subscribe(onNext: { title in
            self.title = title
        }).disposed(by: disposeBag)
        
        viewModel.items.bind(to: collectionView.rx.items(cellIdentifier: "SingleTitleCollectionViewCell", cellType: SingleTitleCollectionViewCell.self)) { index, item, cell in
//            if let cell = cell as? SingleTitleCollectionViewCell {
            cell.configureCell(cellTitle: item)
//            }
        }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
//        collectionView
//            .rx
//            .modelSelected(String.self)
//            .subscribe(onNext: { model in
//
//        }).disposed(by: disposeBag)
        
        Observable
            .zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(String.self))
            .subscribe(onNext: { [unowned self] indexPath, model in
                let alert = UIAlertController.init(title: "Alert", message: "Selected item: \(indexPath.row), model: \(model)", preferredStyle: .alert)
                        self.present(alert, animated: true, completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                alert.dismiss(animated: true, completion: nil)
                            }
                        })
            }).disposed(by: disposeBag)
        
        viewModel.react()
    }
    
    func fetchData() {
        viewModel.getItems()
    }

}

extension CollectionViewTutorialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        return CGSize(width: screenWidth - 20, height: 70)
    }
}
