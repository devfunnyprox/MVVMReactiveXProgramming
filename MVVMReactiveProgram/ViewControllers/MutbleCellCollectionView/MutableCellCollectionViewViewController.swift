//
//  MutbleCellCollectionViewViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//

import UIKit

class MutableCellCollectionViewViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        
        viewModel = MutableCellCollectionViewViewModel()
        
        super.viewDidLoad()
        
        configureCollectionView()
        fetchData()
    }
    
    func configureCollectionView() {
        collectionView.register(UINib.init(nibName: "SingleTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleTitleCollectionViewCell")
        collectionView.register(UINib.init(nibName: "SubtitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubtitleCollectionViewCell")
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel as? MutableCellCollectionViewViewModel else {
            return
        }
        viewModel.items.bind(to: collectionView.rx.items) { (collectionView, row, item) in
            if item.cellType == .singleTitle {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTitleCollectionViewCell", for: IndexPath(item: row, section: 0)) as? SingleTitleCollectionViewCell {
                    cell.configureCell(cellTitle: item.title ?? "")
                    return cell
                }
            } else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubtitleCollectionViewCell", for: IndexPath(item: row, section: 0)) as? SubtitleCollectionViewCell {
                    cell.configureCell(title: item.title ?? "", subTitle: item.subTitle ?? "")
                    return cell
                }
            }
            return UICollectionViewCell()
        }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
    }
    
    func fetchData() {
        guard let viewModel = viewModel as? MutableCellCollectionViewViewModel else {
            return
        }
        viewModel.getItems()
    }
    
}

extension MutableCellCollectionViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        var height: CGFloat = 0
        if let viewModel = viewModel as? MutableCellCollectionViewViewModel {
            if viewModel.dummyModels[indexPath.row].cellType == .singleTitle {
                height = SingleTitleCollectionViewCell.cellHeight()
            } else {
                height = SubtitleCollectionViewCell.cellHeight()
            }
        }
        return CGSize(width: screenWidth - 20, height: height)
    }
}
