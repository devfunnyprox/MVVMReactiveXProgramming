//
//  MutableCellCollectionViewViewModel.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import RxSwift
//import Rx

class MutableCellCollectionViewViewModel: BaseViewModel {
    let items = BehaviorSubject<[DummyModel]>(value: [DummyModel]())
    
    var dummyModels = [DummyModel]()
    let randoms = [1,0,0,0,0,1,1,1,1,0,0,1,0,1,1,1,1,0,0,0]
    
    override func react() {
        
    }
    
    func getItems() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            for i in 1...30 {
                let randomValue = self.randoms.randomElement()
                let model = DummyModel(title: "Title row \(i)", subTitle: "Subtitle row \(i)", cellType: randomValue == 0 ? .singleTitle : .subTitle)
                self.dummyModels.append(model)
            }
            Observable.just(self.dummyModels).bind(to: self.items).disposed(by: self.disposeBag)
        }
    }
}
