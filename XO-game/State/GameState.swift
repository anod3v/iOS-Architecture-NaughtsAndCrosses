//
//  GameState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isMoveCompleted: Bool { get }
    func addSign(at position: GameboardPosition)
    func begin()
}
