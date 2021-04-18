//
//  MutableSectionSingleCellViewModel.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/17/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import RxSwift
import RxDataSources

class MutableSectionSingleCellViewModel: BaseViewModel {
    
    var items = BehaviorSubject<[String]>(value: [String]())
    var itemSources = PublishSubject<[SectionModel<String, String>]>()
    
    let itemSection1 = ["Cell 1", "Cell 2", "Cell 3", "Cell 4", "Cell 5", "Cell 6", "Cell 7", "Cell 8", "Cell 9", "Cell 10", "Cell 11", "Cell 12"]
    
    let itemSection2 = ["Cell 1", "Cell 2", "Cell 3", "Cell 4", "Cell 5", "Cell 6", "Cell 7"]
    
    override func react() {
        
    }
    
    func fetchItems() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let itemSources1 = self.makeSources(["Section 1": self.itemSection1])
            let itemSources2 = self.makeSources(["Section 2": self.itemSection2])
            
            Observable.just(itemSources1 + itemSources2).bind(to: self.itemSources).disposed(by: self.disposeBag)
        }
    }
    
    func makeSources(_ items: [String:[String]]) -> [SectionModel<String, String>] {
        return items.map { SectionModel(model: $0.key, items: $0.value) }
    }
}
