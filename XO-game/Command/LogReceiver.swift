//
//  LogReceiver.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class LogReceiver {
    public static let shared = LogReceiver()
    var commandsSorted: (([LogCommand]) -> Void)?
    init() {}
}
