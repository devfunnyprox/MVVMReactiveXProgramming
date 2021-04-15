//
//  CollectionViewTutorialViewModel.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//

import RxCocoa
import RxSwift
import RxDataSources

class CollectionViewTutorialViewModel {
    
    let disposeBag = DisposeBag()
    let items = BehaviorSubject<[String]>(value: [String]())
    let title = BehaviorSubject<String>(value: "Single Cell CollectionView")
    
    let itemStrings = ["Cell 1", "Cell 2", "Cell 3", "Cell 4", "Cell 5", "Cell 6", "Cell 7", "Cell 8", "Cell 9", "Cell 10", "Cell 11", "Cell 12"]
    
    init() {
        
    }
    
    func react() {
//        getItems()
    }
    
    func getItems() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
//            self.items.onNext(self.itemStrings)
            Observable.just(self.itemStrings).bind(to: self.items).disposed(by: self.disposeBag)
        }
    }
}
