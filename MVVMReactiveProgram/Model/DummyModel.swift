//
//  DummyModel.swift
//  MVVMReactiveProgram
//
//  Created by Nguyen Van Nguyen on 4/15/21.
//  Copyright © 2021 Nguyen Bro. All rights reserved.
//

import Foundation

enum CellType {
    case singleTitle
    case subTitle
}

struct DummyModel {
    var title: String?
    var subTitle: String?
    var cellType: CellType = .singleTitle
}
