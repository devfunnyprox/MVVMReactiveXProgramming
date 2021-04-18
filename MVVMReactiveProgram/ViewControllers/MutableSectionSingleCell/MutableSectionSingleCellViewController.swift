//
//  MutableSectionSingleCellViewController.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/17/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class MutableSectionSingleCellViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    deinit {
        print("MutableSectionSingleCellViewController deinit")
    }
    
    override func viewDidLoad() {
        viewModel = MutableSectionSingleCellViewModel()
        super.viewDidLoad()
        self.title = "MutableSectionSingleCell"
        configureCollectionView()
        guard let viewModel = viewModel as? MutableSectionSingleCellViewModel else {
            return
        }
        viewModel.fetchItems()
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel as? MutableSectionSingleCellViewModel else {
            return
        }
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>  { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTitleCollectionViewCell", for: indexPath) as? SingleTitleCollectionViewCell {
                cell.configureCell(cellTitle: item)
                return cell
            }
            return UICollectionViewCell()
        }
        
        // Can leak? need to check!!!
//        let dataSource1 = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: configureCell)
        
//        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
//            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderTitleCollectionReusableView.identifier, for: indexPath) as? CollectionHeaderTitleCollectionReusableView {
//                let modelSection = dataSource.sectionModels[indexPath.section]
//                header.backgroundColor = .cyan
//                header.configureHeader(title: modelSection.model)
//                return header
//            }
//            return UICollectionReusableView()
//        }
        dataSource.configureSupplementaryView = { [unowned self] dataSource, collectionView, kind, indexPath in
            return self.configureSupplementaryView(dataSource: dataSource, collectionView: collectionView, sectionType: kind, indexPath: indexPath)
        }
        
        viewModel.itemSources.asObservable().bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    func configureCell(dataSource: CollectionViewSectionedDataSource<SectionModel<String, String>>, collectionView: UICollectionView, indexPath: IndexPath, item: CollectionViewSectionedDataSource<SectionModel<String, String>>.Item) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleTitleCollectionViewCell", for: indexPath) as? SingleTitleCollectionViewCell {
            cell.configureCell(cellTitle: item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func configureSupplementaryView(dataSource: CollectionViewSectionedDataSource<SectionModel<String, String>>, collectionView: UICollectionView, sectionType: String, indexPath: IndexPath) -> UICollectionReusableView {
        let modelSection = dataSource.sectionModels[indexPath.section]
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderTitleCollectionReusableView.identifier, for: indexPath) as? CollectionHeaderTitleCollectionReusableView {
            header.backgroundColor = .cyan
            header.configureHeader(title: modelSection.model)
            return header
        }
        return UICollectionReusableView()
    }
    
    func configureCollectionView() {
        collectionView.register(UINib.init(nibName: "SingleTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SingleTitleCollectionViewCell")
        collectionView.register(UINib.init(nibName: "SubtitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubtitleCollectionViewCell")
        collectionView.register(UINib.init(nibName: CollectionHeaderTitleCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderTitleCollectionReusableView.identifier)
    }

}

extension MutableSectionSingleCellViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
    }
}
