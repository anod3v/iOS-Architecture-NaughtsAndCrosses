//
//  Prototype.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
