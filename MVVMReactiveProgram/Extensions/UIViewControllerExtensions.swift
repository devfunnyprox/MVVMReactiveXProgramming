//
//  UIViewControllerExtensions.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//
import UIKit
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var title: Binder<String?> {
        return Binder(self.base) { $0.title = $1 }
    }
}
